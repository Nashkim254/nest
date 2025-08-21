import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PasswordProtectedDialogModel extends BaseViewModel {
  bool isPasswordVisible = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  String? validateCurrentPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Current password is required';
    }
    // Add additional validation logic if needed
    return null;
  }

  void submitForm(Function(DialogResponse) completer) {
    if (formKey.currentState?.validate() ?? false) {
      completer(DialogResponse(confirmed: true, data: {
        'password': passwordController.text,
      }));
    } else {
      completer(DialogResponse(confirmed: false));
    }
  }
}
