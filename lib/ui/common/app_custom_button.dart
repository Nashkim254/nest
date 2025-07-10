import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.labelText,
    required this.onTap,
    this.buttonColor = kcPrimaryColor,
    this.height = 52,
    this.width = double.infinity,
  }) : super(key: key);
  final String labelText;
  final VoidCallback onTap;
  final Color? buttonColor;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(17),
          ),
        ),
        child: Center(
          child: Text(
            labelText,
            style: bodyTextMedium,
          ),
        ),
      ),
    );
  }
}
