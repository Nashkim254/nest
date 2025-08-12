import 'package:nest/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/registration_model.dart';
import '../../../services/location_service.dart';
import '../../../services/shared_preferences_service.dart';
import 'location_view.form.dart';

class LocationViewModel extends FormViewModel with $LocationView {
  final navigator = locator<NavigationService>();
  final prefsService = locator<SharedPreferencesService>();

  goToRegisterView(RegistrationModel registrationModel) async {
    await prefsService.setFirstTimeLaunch(false);

    navigator.navigateToRegisterView(registrationModel: registrationModel);
  }

  getCurrentLocation() async {
    setBusy(true);
    try {
      String? result = await locator<LocationService>().getCurrentCity();
      manualLocationController.text = result ?? '';
      await prefsService.setLastKnownLocation(result!);
    } catch (e) {
      manualLocationController.text = '';
      await prefsService.setLastKnownLocation('');
      locator<DialogService>().showDialog(
        title: 'Error',
        description: 'Could not get current location. Please try again later.',
      );
    } finally {
      setBusy(false);
    }
  }
}
