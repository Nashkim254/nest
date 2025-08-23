import '../ui/common/app_enums.dart';

class PaymentMethod {
  final PaymentMethodType type;
  final String displayName;
  final String iconPath;

  PaymentMethod({
    required this.type,
    required this.displayName,
    required this.iconPath,
  });
}
