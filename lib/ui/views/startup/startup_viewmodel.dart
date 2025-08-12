import 'package:stacked/stacked.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/shared_preferences_service.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final prefsService = locator<SharedPreferencesService>();

  // Place anything here that needs to happen before we get into the application
  Future getStarted() async {
    bool isFirstLaunch = prefsService.isFirstTimeLaunch();
    if (isFirstLaunch) {
      _navigationService.replaceWithInterestSelectionView();
    } else {
      bool isLoggedIn = prefsService.getIsLoggedIn();
      if (isLoggedIn) {
        _navigationService.replaceWithHomeView();
      } else {
        _navigationService.replaceWithLoginView();
      }
    }
  }
}
