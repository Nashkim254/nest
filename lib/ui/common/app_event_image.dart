import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';

class AppEventImage extends StatelessWidget {
  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AppEventImage({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // If no image URL provided, show placeholder immediately
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildPlaceholder();
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.network(
        imageUrl!,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildLoadingPlaceholder(loadingProgress);
        },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? _buildPlaceholder();
        },
      ),
    );
  }

  Widget _buildPlaceholder() {
    return placeholder ??
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: kcMediumGrey.withOpacity(0.1),
            borderRadius: borderRadius ?? BorderRadius.zero,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.image_outlined,
                size: height != null && height! < 80 ? 24 : 48,
                color: kcMediumGrey,
              ),
              if (height == null || height! >= 60) ...[
                const SizedBox(height: 4),
                Text(
                  'Event Image',
                  style: TextStyle(
                    color: kcMediumGrey,
                    fontSize: height != null && height! < 80 ? 10 : 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        );
  }

  Widget _buildLoadingPlaceholder(ImageChunkEvent loadingProgress) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: kcMediumGrey.withOpacity(0.1),
        borderRadius: borderRadius ?? BorderRadius.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                : null,
            strokeWidth: 2,
            color: kcPrimaryColor,
          ),
          const SizedBox(height: 8),
          const Text(
            'Loading...',
            style: TextStyle(
              color: kcMediumGrey,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}