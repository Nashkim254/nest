import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends FormViewModel {
  login() {
    locator<NavigationService>().navigateToNavigationView();
  }

  void signup() {
    locator<NavigationService>().navigateToRegisterView();
  }
}
