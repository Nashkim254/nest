import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'share_sheet_model.dart';

class ShareSheet extends StackedView<ShareSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const ShareSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ShareSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: kcDarkColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                request.title ?? 'Hello Stacked Sheet!!',
                style: titleTextMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: kcWhiteColor),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: kcWhiteColor),
                onPressed: () {
                  if (completer != null) {
                    completer!(SheetResponse(confirmed: true));
                  }
                  // viewModel.closeSheet();
                },
              ),
            ],
          ),
          verticalSpaceLarge,
          _buildShareViaSocials(context, viewModel),
          verticalSpaceMedium,
          _buildShareOptions(context, viewModel),
        ],
      ),
    );
  }

  @override
  ShareSheetModel viewModelBuilder(BuildContext context) => ShareSheetModel();
}

Widget _buildShareViaSocials(BuildContext context, ShareSheetModel viewModel) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: List.generate(
      viewModel.socials.length,
      (int index) => _buildSocialWidget(
        viewModel.socials[index],
      ),
    ),
  );
}

Widget _buildSocialWidget(Map<String, dynamic> social) {
  return Column(
    children: [
      Container(
        height: 56,
        width: 56,
        decoration: const BoxDecoration(
          color: kcDarkGreyColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: SvgPicture.asset(social['icon'], color: kcWhiteColor,),
        ),
      ),
      verticalSpaceSmall,
      Text(
        social['name'],
        style: titleTextMedium.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: kcWhiteColor,
        ),
      ),
    ],
  );
}

Widget _buildShareOptions(BuildContext context, ShareSheetModel viewModel) {
  return Column(
    children: [
      ListTile(
        leading: SvgPicture.asset(send),
        title: Text(
          'Direct Message',
          style: titleTextMedium.copyWith(color: kcWhiteColor),
        ),
        onTap: () => viewModel.shareViaDM(),
      ),
      ListTile(
        leading: SvgPicture.asset(copy),
        title: Text(
          'Copy Link',
          style: titleTextMedium.copyWith(color: kcWhiteColor),
        ),
        onTap: () => viewModel.copyLink(),
      ),
      ListTile(
        leading: SvgPicture.asset(report),
        title: Text(
          'Report',
          style: titleTextMedium.copyWith(color: kcWhiteColor),
        ),
        onTap: () => viewModel.report(),
      ),
    ],
  );
}
