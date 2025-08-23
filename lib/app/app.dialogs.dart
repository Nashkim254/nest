// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/add_social/add_social_dialog.dart';
import '../ui/dialogs/change_password/change_password_dialog.dart';
import '../ui/dialogs/comments/comments_dialog.dart';
import '../ui/dialogs/info_alert/info_alert_dialog.dart';
import '../ui/dialogs/password_protected/password_protected_dialog.dart';
import '../ui/dialogs/payment_successful/payment_successful_dialog.dart';

enum DialogType {
  infoAlert,
  comments,
  changePassword,
  addSocial,
  passwordProtected,
  paymentSuccessful,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.infoAlert: (context, request, completer) =>
        InfoAlertDialog(request: request, completer: completer),
    DialogType.comments: (context, request, completer) =>
        CommentsDialog(request: request, completer: completer),
    DialogType.changePassword: (context, request, completer) =>
        ChangePasswordDialog(request: request, completer: completer),
    DialogType.addSocial: (context, request, completer) =>
        AddSocialDialog(request: request, completer: completer),
    DialogType.passwordProtected: (context, request, completer) =>
        PasswordProtectedDialog(request: request, completer: completer),
    DialogType.paymentSuccessful: (context, request, completer) =>
        PaymentSuccessfulDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
