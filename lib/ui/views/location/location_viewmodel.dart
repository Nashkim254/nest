import 'package:nest/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class LocationViewModel extends FormViewModel {
  final navigator = locator<NavigationService>();

  goToLoginView() {
    navigator.navigateToLoginView();
  }
}
