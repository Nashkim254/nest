import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddSocialDialogModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController socialLinkController = TextEditingController();
  final TextEditingController socialNameController = TextEditingController();
  String selectedSocialType = 'Instagram';
  final List<String> socialTypes = [
    'Instagram',
    'Facebook',
    'Twitter',
    'LinkedIn',
  ];
  void submitForm(Function(DialogResponse) completer) {
    if (formKey.currentState?.validate() ?? false) {
      completer(DialogResponse(
        confirmed: true,
        data: {
          'socialLink': socialLinkController.text,
          'socialName': selectedSocialType,
        },
      ));
    } else {
      completer(DialogResponse(confirmed: false));
    }
  }
}
