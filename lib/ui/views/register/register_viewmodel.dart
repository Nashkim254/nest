import 'package:logger/logger.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/models/registration_model.dart';
import 'package:nest/services/auth_service.dart';
import 'package:nest/ui/views/register/register_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class RegisterViewModel extends BaseViewModel with $RegisterView {
  final navigationService = locator<NavigationService>();
  final authService = locator<AuthService>();
  signin() {
    navigationService.replaceWithLoginView();
  }

  register(RegistrationModel registrationModel) async {
    registrationModel = registrationModel.copyWith(
      email: emailController.text,
      password: passwordController.text,
      phoneNumber: phoneController.text,
      firstName: nameController.text.split(' ').first,
      lastName: nameController.text.split(' ').length > 1
          ? nameController.text.split(' ').sublist(1).join(' ')
          : '',
    );
    setBusy(true);
    Logger().i(registrationModel.toJson());
    final result = await authService.register(registrationModel);
    Logger().i(result);
    if (result is Exception) {
      setBusy(false);
      Logger().e(result.toString());
      await locator<DialogService>().showDialog(
        title: 'Registration Failed',
        description: result.toString(),
      );
      return;
    }
    setBusy(false);
  }
}
