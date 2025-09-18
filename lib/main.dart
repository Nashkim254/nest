import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:nest/app/app.bottomsheets.dart';
import 'package:nest/app/app.dialogs.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/services/api_service.dart';
import 'package:nest/services/auth_service.dart';
import 'package:nest/services/deep_link_service.dart';
import 'package:nest/services/shared_preferences_service.dart';
import 'package:nest/services/social_service.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:nest/ui/views/startup/startup_view.dart';
import 'package:nest/models/post_models.dart';

import 'abstractClasses/abstract_class.dart';
import 'handlers/event_deeplink_handler.dart';
import 'handlers/password_reset_handler.dart';
import 'handlers/post_deeplink_handler.dart';
import 'handlers/profile_deeplink_handler.dart';
import 'handlers/verification_handler.dart';
import 'models/password_reset_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  setupServiceLocator();
  await dotenv.load(fileName: '.env');
  runApp(const MainApp());
}

void setupServiceLocator() {
  locator.registerLazySingleton<IApiService>(
    () => ApiService(
      connectTimeout: 30000,
      receiveTimeout: 30000,
    ),
  );
  locator.registerLazySingleton<SnackbarService>(() => SnackbarService());
  locator<SharedPreferencesService>().init();

}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    _initializeDeepLinks();
  }

  void _initializeDeepLinks() async {
    final DeepLinkService deepLinkService = locator<DeepLinkService>();
    await deepLinkService.initialize();

    // Register handlers
    deepLinkService.registerHandler(
      PostDeepLinkHandler(
        onPostRequested: (postId) async {
          // Fetch the specific post and navigate to VideoPlayerView
          try {
            final socialService = locator<SocialService>();
            final response = await socialService.getPostById(postId: postId);

            if (response.statusCode == 200 || response.statusCode == 201) {
              final postData = response.data;
              final post = Post.fromJson(postData);

              // Navigate to appropriate view based on post type
              if (post.hasVideo &&
                  post.videoReady &&
                  post.videoUrl != null &&
                  post.videoUrl!.isNotEmpty) {
                // Navigate to VideoPlayerView for ready video posts
                locator<NavigationService>()
                    .navigateToVideoPlayerView(post: post);
              } else if (post.hasImages) {
                // Navigate to ForYouView for image posts to show in feed context
                locator<NavigationService>().navigateToForYouView();
              } else if (post.hasVideo && !post.videoReady) {
                // Show message for videos that aren't ready yet
                locator<SnackbarService>().showSnackbar(
                  message: 'Video is still processing. Please try again later.',
                  title: 'Video Processing',
                  duration: const Duration(seconds: 3),
                );
                locator<NavigationService>().navigateToForYouView();
              } else {
                // Navigate to ForYouView for text posts or other content
                locator<NavigationService>().navigateToForYouView();
              }
            } else {
              // If post fetch fails, show error and navigate to general feed
              locator<SnackbarService>().showSnackbar(
                message: 'Post not found or access denied',
                title: 'Error',
                duration: const Duration(seconds: 3),
              );
              locator<NavigationService>().navigateToForYouView();
            }
          } catch (e) {
            // Handle error - show message and navigate to general feed
            locator<SnackbarService>().showSnackbar(
              message: 'Failed to load post: $e',
              title: 'Error',
              duration: const Duration(seconds: 3),
            );
            locator<NavigationService>().navigateToForYouView();
          }
        },
      ),
    );

    deepLinkService.registerHandler(
      EventDeepLinkHandler(
        onEventRequested: (eventId) {
          // Navigate to explore events view or specific event view
          locator<NavigationService>().navigateToExploreEventsView();
        },
      ),
    );

    deepLinkService.registerHandler(
      ProfileDeepLinkHandler(
        onProfileRequested: (userId) {
          // Navigate to profile view
          locator<NavigationService>().navigateToProfileView(isOtherUser: true);
        },
      ),
    );

    deepLinkService.registerHandler(
      VerificationDeepLinkHandler(
        onVerificationRequested: (token, email) async {
          // Handle verification link - call API to verify email
          Logger().i('Verification requested for $email with token: $token');

          try {
            final authService = locator<AuthService>();

            final response = await authService.verifyEmail(token);
            Logger().i('Verification response: ${response.data}');
            if (response.statusCode == 200 || response.statusCode == 201) {
              //navigate to login
              locator<NavigationService>().clearStackAndShow(Routes.loginView);
              // Show success message
              locator<SnackbarService>().showSnackbar(
                message: 'Email verified successfully!',
                title: 'Success',
                duration: const Duration(seconds: 3),
              );
            }
          } catch (e) {
            // Show error message
            locator<SnackbarService>().showSnackbar(
              message: 'Email verification failed: $e',
              title: 'Error',
              duration: const Duration(seconds: 3),
            );
          }
        },
      ),
    );

    deepLinkService.registerHandler(
      PasswordResetDeepLinkHandler(
        onPasswordResetRequested: (token) async {
          // Handle password reset link - automatically use saved password
          Logger().i('Password reset requested with token: $token');

          try {
            final authService = locator<AuthService>();
            final sharedPrefsService = locator<SharedPreferencesService>();

            // Get saved password from temp storage
            final savedPassword =
                sharedPrefsService.getString('temp_reset_password');
            final savedConfirmPassword =
                sharedPrefsService.getString('temp_reset_confirm_password');

            if (savedPassword == null || savedConfirmPassword == null) {
              throw Exception(
                  'No saved password found. Please try the reset process again from settings.');
            }

            final resetModel = PasswordResetModel(
              token: token,
              password: savedPassword,
            );
            Logger().w('Resetting password with model: ${resetModel.toJson()}');
            final response = await authService.resetPassword(resetModel);
            if (response.statusCode == 200 || response.statusCode == 201) {
              // Clear temp passwords after successful reset
              await sharedPrefsService.remove('temp_reset_password');
              await sharedPrefsService.remove('temp_reset_confirm_password');

              // Clear all user data and navigate to login
              await sharedPrefsService.clearAuthToken();
              await sharedPrefsService.setIsLoggedIn(false);
              await sharedPrefsService.remove('userInfo');
              await sharedPrefsService.remove('service_fee');
              await sharedPrefsService.remove('token_expiry');
              await sharedPrefsService.remove('eventId');
              await sharedPrefsService.remove('ticketId');
              // Navigate to login after successful reset
              locator<NavigationService>().clearStackAndShow(Routes.loginView);
              locator<SnackbarService>().showSnackbar(
                message:
                    'Password reset successfully! Please login with your new password.',
                title: 'Success',
                duration: const Duration(seconds: 3),
              );
            } else {
              throw Exception(
                  'Password reset failed with status: ${response.statusCode}');
            }
          } catch (e) {
            // // Clear temp passwords on error
            // final sharedPrefsService = locator<SharedPreferencesService>();
            // await sharedPrefsService.remove('temp_reset_password');
            // await sharedPrefsService.remove('temp_reset_confirm_password');

            // Show error message
            locator<SnackbarService>().showSnackbar(
              message: 'Password reset failed: $e',
              title: 'Error',
              duration: const Duration(seconds: 3),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const StartupView(),
          settings: settings,
        );
      },
    );
  }
}
