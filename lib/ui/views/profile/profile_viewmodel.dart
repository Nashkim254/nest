import 'package:logger/logger.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/models/message_models.dart';
import 'package:nest/models/profile.dart';
import 'package:nest/models/user_serach_ressult.dart';
import 'package:nest/services/shared_preferences_service.dart';
import 'package:nest/services/social_service.dart';
import 'package:nest/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/post_models.dart';
import '../../../services/global_service.dart';

class ProfileViewModel extends ReactiveViewModel {
  bool get isUser => !isOtherUser;
  bool isOtherUser = false;

  final globalService = locator<GlobalService>();
  final userService = locator<UserService>();
  final socialService = locator<SocialService>();
  Logger logger = Logger();
  Profile? profile;
  onEditProfile() async {
    final result =
        await locator<NavigationService>().navigateToEditProfileView();
    if (result != null && result is bool && result) {
      await getUserProfile(true);
    }
  }

  void handleEventTap(Post selected) {
    // final reorderedList = [
    //   selected,
    //   ...posts.where((e) => e != selected),
    // ];
    locator<NavigationService>().navigateTo(
      Routes.eventActivityView,
    );
  }

  refresh() async {
    if (isUser) {
      await getUserProfile(true);
    } else {
      await getOtherUserProfile();
    }
  }

  void goToChatView() {
    locator<NavigationService>().navigateToMessagesView();
  }

  cretePost() async {
    final result =
        await locator<NavigationService>().navigateTo(Routes.createPostView);
    if (result != null && result is bool && result) {
      await getUserPosts();
    }
  }

  getUser() {
    var user = locator<SharedPreferencesService>().getUserInfo();
    profile = Profile.fromJson(user!);
    notifyListeners();
  }

  init(bool isOtherUser) async {
    this.isOtherUser = isOtherUser;
    if (isOtherUser) {
      await getOtherUserProfile();
      return;
    }
    await getUserProfile(false);
    await getUserPosts();
  }

  Future getUserProfile(bool isRefresh) async {
    // if (!isRefresh) {
    //   await getUser();
    //   if (profile != null) {
    //     logger.i('User profile already loaded: ${profile!.toJson()}');
    //     return;
    //   }
    // }

    setBusy(true);
    try {
      final response = await userService.getUserProfile();
      if (response.statusCode == 200 && response.data != null) {
        profile = Profile.fromJson(response.data);
        locator<SharedPreferencesService>().setUserInfo(response.data);
        logger.i('User profile loaded successfully: ${response.data}');
      } else {
        throw Exception(response.message ?? 'Failed to load user profile');
      }
    } catch (e, s) {
      logger.i('error: $e');
      logger.e('error: $s');

      locator<SnackbarService>().showSnackbar(
        message: 'Failed to load user profile: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  UserSearchResult? otherUser;
  Future getOtherUserProfile() async {
    setBusy(true);
    try {
      final response =
          await userService.getOtherUserProfile(globalService.otherUserId);
      if (response.statusCode == 200 && response.data != null) {
        profile = Profile.fromJson(response.data);
        otherUser = UserSearchResult.fromJson(response.data);
        otherUser = otherUser!.copyWith(firstName: response.data['name']);
        logger.i(
            'Other User profile loaded successfully: ${otherUser!.toJson()}');
      } else {
        throw Exception(response.message ?? 'Failed to load user profile');
      }
    } catch (e, s) {
      logger.i('error: $e');
      logger.e('error: $s');

      locator<SnackbarService>().showSnackbar(
        message: 'Failed to load user profile: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  int page = 1;
  int size = 10;
  List<Post> posts = [];
  Future getUserPosts() async {
    setBusy(true);
    try {
      int id = isOtherUser
          ? globalService.otherUserId
          : locator<SharedPreferencesService>().getUserInfo()!['id'];

      final response =
          await socialService.getUserPosts(page: page, size: size, id: id);
      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> postsJson = response.data['posts'];
        logger.i('User posts loaded successfully: ${postsJson.length}');
        // Convert each JSON object to Post model
        posts = postsJson.map((postJson) => Post.fromJson(postJson)).toList();
        notifyListeners();
      } else {
        throw Exception(response.message ?? 'Failed to load user posts');
      }
    } catch (e, s) {
      logger.i('error: $e');
      logger.e('error: $s');

      locator<SnackbarService>().showSnackbar(
        message: 'Failed to load user posts: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

//url launcher to open links to socials
  Future openSocialLink(String url) async {
    try {
      await userService.openSocialLink(url);
    } catch (e) {
      locator<SnackbarService>().showSnackbar(
        message: 'Could not open the link: $e',
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future followUnfollowUser(int id, bool isFollow) async {
    setBusy(true);
    try {
      final response =
          await userService.followUnfollowUser(id: id, isFollow: isFollow);
      if (response.statusCode == 200 && response.data != null) {
        locator<SnackbarService>().showSnackbar(
          message: isFollow ? 'User followed' : 'User unfollowed',
          duration: const Duration(seconds: 2),
        );
        logger.i('User followed/unfollowed successfully: ${response.data}');
      } else {
        throw Exception(response.message ?? 'Failed to followed/unfollowed');
      }
    } catch (e, s) {
      logger.i('error: $e');
      logger.e('error: $s');

      locator<SnackbarService>().showSnackbar(
        message: 'Failed to load user profile: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [globalService];
}
