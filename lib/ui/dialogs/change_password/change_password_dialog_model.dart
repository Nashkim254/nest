import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nest/services/global_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/auth_service.dart';
import '../../../services/shared_preferences_service.dart';
import '../../../models/password_reset_model.dart';

class ChangePasswordDialogModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final authService = locator<AuthService>();
  final globalService = locator<GlobalService>();
  final prefsService = locator<SharedPreferencesService>();
  final logger = Logger();
  String? currentPassword;
  String? newPassword;
  String? confirmPassword;
  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isNewPasswordVisible = false;
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final FocusNode currentPasswordFocusNode = FocusNode();
  final FocusNode newPasswordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible = !isNewPasswordVisible;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    notifyListeners();
  }

  void submitForm(Function(DialogResponse) completer) {
    if (formKey.currentState?.validate() ?? false) {

      isLoading = true;
      notifyListeners();
      final requestModel = PasswordResetRequestModel(
        email: prefsService.getUserInfo()!['email'],
        appLaunch: 'https://api.nesthaps.com',
      );
      try {
        authService.requestChangePassword(requestModel).then((response) {
          if (response.statusCode == 200) {
            completer(DialogResponse(confirmed: true));
            locator<SnackbarService>().showSnackbar(
              message: response.data['message'] ??
                  'Password change request successful',
              duration: const Duration(seconds: 2),
            );
            isLoading = false;
            notifyListeners();
            // Optionally, close the dialog or show a success message
          } else {
            // Handle failure (e.g., incorrect current password)
            isLoading = false;
            notifyListeners();
            // Optionally, show an error message
          }
        }).catchError((error) {
          isLoading = false;
          notifyListeners();
          // Handle any errors that occur during the password change
        });
      } catch (e) {
        isLoading = false;
        notifyListeners();
        // Handle any exceptions that occur during the process
      }
    }
  }

  void resetPassword(Function(DialogResponse) completer) {
    if (formKey.currentState?.validate() ?? false) {
      isLoading = true;
      notifyListeners();
      final requestModel = PasswordResetRequestModel(
        email: prefsService.getUserInfo()!['email'],
        appLaunch: 'https://api.nesthaps.com',
      );
      try {
        authService.requestChangePassword(requestModel).then((response) {
          if (response.statusCode == 200) {
            completer(DialogResponse(confirmed: true));
            locator<SnackbarService>().showSnackbar(
              message: response.data['message'] ??
                  'Password change request successful',
              duration: const Duration(seconds: 2),
            );
            isLoading = false;
            notifyListeners();
            // Optionally, close the dialog or show a success message
          } else {
            // Handle failure (e.g., incorrect current password)
            isLoading = false;
            notifyListeners();
            // Optionally, show an error message
          }
        }).catchError((error) {
          isLoading = false;
          notifyListeners();
          // Handle any errors that occur during the password change
        });
      } catch (e) {
        isLoading = false;
        notifyListeners();
        // Handle any exceptions that occur during the process
      }
    }
  }

  String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Current password is required';
    }
    // Add additional validation logic if needed
    return null;
  }

  void requestPasswordReset(Function(DialogResponse) completer) {
    if (formKey.currentState?.validate() ?? false) {
      // Return the new password data to the caller
      completer(DialogResponse(
        confirmed: true,
        data: {
          'newPassword': newPasswordController.text,
          'confirmPassword': confirmPasswordController.text,
        },
      ));
    }
  }

  String? validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'New password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    // Add additional validation logic if needed
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    print('value: $value, newPassword: ${newPasswordController.text}');
    if (value != newPasswordController.text) {
      return 'Passwords do not match';
    }
    // Add additional validation logic if needed
    return null;
  }
}
