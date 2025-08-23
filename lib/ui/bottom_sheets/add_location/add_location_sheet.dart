import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_inputdecoration.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../common/app_styles.dart';
import 'add_location_sheet_model.dart';

class AddLocationSheet extends StackedView<AddLocationSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const AddLocationSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AddLocationSheetModel viewModel,
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
          verticalSpaceSmall,
          Row(
            children: [
              Text(
                'Add Location',
                style: titleTextMedium.copyWith(fontSize: 20),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: kcWhiteColor),
                onPressed: () => viewModel.closeSheet(),
              ),
            ],
          ),
          verticalSpaceMedium,
          TextFormField(
            controller: viewModel.searchController,
            decoration: AppInputDecoration.search(
              hintText: 'Search for a location',
              fillColor: kcGreyButtonColor,
            ),
            style: titleTextMedium.copyWith(color: kcWhiteColor),
            onChanged: viewModel.onSearchChanged,
          ),
          verticalSpaceMedium,
          InkWell(
            onTap: viewModel.isBusy ? null : () => viewModel.showStatesSheet(),
            child: Row(
              children: [
                SvgPicture.asset(pin, color: kcPrimaryColor),
                horizontalSpaceSmall,
                viewModel.isBusy
                    ? const CircularProgressIndicator(color: kcPrimaryColor)
                    : Text(
                        'Current Location',
                        style: titleTextMedium.copyWith(
                          fontSize: 16,
                          color: kcWhiteColor,
                        ),
                      ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: viewModel.filteredStates.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    viewModel.filteredStates[index],
                    style: titleTextMedium.copyWith(color: kcWhiteColor),
                  ),
                  onTap: () {
                    viewModel.selectLocation(
                      viewModel.filteredStates[index],
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => spacedDivider,
            ),
          ),
        ],
      ),
    );
  }

  @override
  AddLocationSheetModel viewModelBuilder(BuildContext context) =>
      AddLocationSheetModel();
}
