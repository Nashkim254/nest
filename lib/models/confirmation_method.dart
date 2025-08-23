import '../ui/common/app_enums.dart';

class ConfirmationMethod {
  final ConfirmationMethodType type;
  final String displayName;
  final String iconPath;

  ConfirmationMethod({
    required this.type,
    required this.displayName,
    required this.iconPath,
  });
}
