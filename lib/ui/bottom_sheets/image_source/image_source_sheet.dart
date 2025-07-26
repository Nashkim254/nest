import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../common/app_enums.dart';
import '../../common/app_styles.dart';
import 'image_source_sheet_model.dart';

class ImageSourceSheet extends StackedView<ImageSourceSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const ImageSourceSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ImageSourceSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: const BoxDecoration(
        color: kcDarkColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: kcGreyButtonColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          verticalSpaceMedium,
          Text(
            'Select Image Source',
            style: titleTextMedium.copyWith(fontSize: 20),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildSourceOption(
                context,
                icon: Icons.camera_alt,
                label: 'Camera',
                color: kcSecondaryColor,
                onTap: () => viewModel.selectSource(ImageSourceType.camera),
              ),
              _buildSourceOption(
                context,
                icon: Icons.photo_library,
                label: 'Gallery',
                color: kcTertiaryColor,
                onTap: () => viewModel.selectSource(ImageSourceType.gallery),
              ),
              _buildSourceOption(
                context,
                icon: Icons.photo_library_outlined,
                label: 'Multiple',
                color: kcPrimaryColor,
                onTap: () => viewModel.selectSource(ImageSourceType.multiple),
              ),
            ],
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: viewModel.cancel,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: kcBorderColor),
                ),
              ),
              child: Text(
                'Cancel',
                style:
                    titleTextMedium.copyWith(fontSize: 16, color: kcGreyColor),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ImageSourceSheetModel viewModelBuilder(BuildContext context) =>
      ImageSourceSheetModel();
}
