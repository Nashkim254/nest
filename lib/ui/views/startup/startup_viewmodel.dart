import 'package:stacked/stacked.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/shared_preferences_service.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final prefsService = locator<SharedPreferencesService>();

  void onViewModelReady() {
    _checkAuthenticationStatus();
  }

  /// Check authentication status on app startup
  Future<void> _checkAuthenticationStatus() async {
    // Give a small delay for splash screen effect
    await Future.delayed(const Duration(milliseconds: 1500));

    // Check if user has a valid (non-expired) token
    if (prefsService.hasValidToken()) {
      // Token is valid, navigate directly to main app
      _navigationService.replaceWithNavigationView();
    }
    // If no valid token, stay on startup view for user to decide
  }

  // Place anything here that needs to happen before we get into the application
  Future getStarted() async {
    bool isFirstLaunch = prefsService.isFirstTimeLaunch();
    if (isFirstLaunch) {
      _navigationService.replaceWithInterestSelectionView();
    } else {
      bool isLoggedIn = prefsService.getIsLoggedIn();

      _navigationService.replaceWithLoginView();
    }
  }

  Future<void> navigateToLogin() async {
    await _navigationService.replaceWithLoginView();
  }
}
