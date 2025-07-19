import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.labelText,
    required this.onTap,
    this.buttonColor = kcPrimaryColor,
    this.borderColor = Colors.transparent,
    this.height = 52,
    this.width = double.infinity,
    this.leadingIcon,
  }) : super(key: key);
  final String labelText;
  final VoidCallback onTap;
  final Color? buttonColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  final String? leadingIcon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(color: borderColor!),
          borderRadius: const BorderRadius.all(
            Radius.circular(17),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leadingIcon == null
                  ? const SizedBox()
                  : SvgPicture.asset(leadingIcon!),
              leadingIcon == null ? const SizedBox() : const SizedBox(width: 8),
              Text(
                labelText,
                style: bodyTextMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
