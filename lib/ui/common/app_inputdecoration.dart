import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_styles.dart';

class AppInputDecoration {
  // Static method approach - most common for InputDecoration
  static InputDecoration standard({
    String? labelText,
    String? hintText,
    String? helperText,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool enabled = true,
    bool filled = true,
    Color? fillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    double borderRadius = 8.0,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabled: enabled,
      filled: filled,
      fillColor: fillColor ?? kcOffWhite8Grey,
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      // Text and icon styling
      hintStyle: titleTextMedium.copyWith(color: kcTGreyTextColor),
      labelStyle: titleTextMedium.copyWith(color: kcTGreyTextColor),
      prefixIconColor: kcTGreyTextColor,
      suffixIconColor: kcTGreyTextColor,

      // Border styling
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: borderColor ?? kcContainerBorderColor,
          width: 1.0,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: borderColor ?? kcContainerBorderColor,
          width: 1.0,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: focusedBorderColor ?? kcContainerBorderColor,
          width: 2.0,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: errorBorderColor ?? Colors.red,
          width: 1.0,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: errorBorderColor ?? Colors.red,
          width: 2.0,
        ),
      ),

      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(
          color: kcContainerBorderColor,
          width: 1.0,
        ),
      ),
    );
  }

  // Alternative: Underline input decoration
  static InputDecoration underline({
    String? labelText,
    String? hintText,
    String? helperText,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool enabled = true,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? errorBorderColor,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabled: enabled,
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(horizontal: 0, vertical: 16),

      // Text and icon styling
      hintStyle: titleTextMedium.copyWith(color: kcTGreyTextColor),
      labelStyle: titleTextMedium.copyWith(color: kcTGreyTextColor),
      prefixIconColor: kcTGreyTextColor,
      suffixIconColor: kcTGreyTextColor,

      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: borderColor ?? kcContainerBorderColor,
          width: 1.0,
        ),
      ),

      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: borderColor ?? kcContainerBorderColor,
          width: 1.0,
        ),
      ),

      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: focusedBorderColor ?? Colors.blue,
          width: 2.0,
        ),
      ),

      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: errorBorderColor ?? Colors.red,
          width: 1.0,
        ),
      ),

      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: errorBorderColor ?? Colors.red,
          width: 2.0,
        ),
      ),
    );
  }

  // Material 3 styled input decoration
  static InputDecoration material3({
    String? labelText,
    String? hintText,
    String? helperText,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool enabled = true,
    bool filled = true,
    Color? fillColor,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabled: enabled,
      filled: filled,
      fillColor: fillColor ?? kcOffWhite8Grey,
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      // Text and icon styling
      hintStyle: titleTextMedium.copyWith(color: kcTGreyTextColor),
      labelStyle: titleTextMedium.copyWith(color: kcTGreyTextColor),
      prefixIconColor: kcTGreyTextColor,
      suffixIconColor: kcTGreyTextColor,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 2.0,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
    );
  }

  // Rounded input decoration
  static InputDecoration rounded({
    String? labelText,
    String? hintText,
    String? helperText,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool enabled = true,
    bool filled = true,
    Color? fillColor,
    Color? borderColor,
    Color? focusedBorderColor,
    double borderRadius = 25.0,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabled: enabled,
      filled: filled,
      fillColor: fillColor ?? kcOffWhite8Grey,
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(horizontal: 20, vertical: 16),

      // Text and icon styling
      hintStyle: titleTextMedium.copyWith(color: kcTGreyTextColor),
      labelStyle: titleTextMedium.copyWith(color: kcTGreyTextColor),
      prefixIconColor: kcTGreyTextColor,
      suffixIconColor: kcTGreyTextColor,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: borderColor ?? kcContainerBorderColor,
          width: 1.0,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: borderColor ?? kcContainerBorderColor,
          width: 1.0,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(
          color: focusedBorderColor ?? kcContainerBorderColor,
          width: 2.0,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
    );
  }

  // Search input decoration
  static InputDecoration search({
    String? hintText = 'Search...',
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool enabled = true,
    Color? fillColor,
    double borderRadius = 20.0,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: prefixIcon ?? const Icon(Icons.search),
      suffixIcon: suffixIcon,
      enabled: enabled,
      filled: true,
      fillColor: fillColor ?? kcOffWhite8Grey,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      // Text and icon styling
      hintStyle: titleTextMedium.copyWith(color: kcTGreyTextColor),
      prefixIconColor: kcTGreyTextColor,
      suffixIconColor: kcTGreyTextColor,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(
          color: kcContainerBorderColor,
          width: 2.0,
        ),
      ),
    );
  }
}
