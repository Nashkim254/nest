import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_inputdecoration.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../common/app_styles.dart';
import 'tag_people_sheet_model.dart';

class TagPeopleSheet extends StackedView<TagPeopleSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const TagPeopleSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TagPeopleSheetModel viewModel,
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
          TextField(
            style: titleTextMedium.copyWith(fontSize: 15),
            controller: viewModel.searchController,
            decoration: AppInputDecoration.search(
              hintText: 'Search users',
            ),
            onChanged: viewModel.onSearchChanged,
          ),
          verticalSpaceMedium,
          Expanded(
            child: ListView.separated(
              itemCount: viewModel.filteredUsers.length,
              itemBuilder: (context, index) {
                final user = viewModel.filteredUsers[index];
                return ListTile(
                  onTap: () => viewModel.toggleTagUser(user, index),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(user.imageUrl),
                  ),
                  title: Text(
                    user.name,
                    style: titleTextMedium.copyWith(
                      fontSize: 15,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      viewModel.isUserTagged(index)
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: viewModel.isUserTagged(index)
                          ? kcPrimaryColor
                          : kcGreyButtonColor,
                    ),
                    onPressed: () => viewModel.toggleTagUser(user, index),
                  ),
                );
              },
              separatorBuilder: (context, index) => spacedDivider,
            ),
          ),
          AppButton(
            labelText: 'Done',
            onTap: () => viewModel.tag(),
          ),
        ],
      ),
    );
  }

  @override
  TagPeopleSheetModel viewModelBuilder(BuildContext context) =>
      TagPeopleSheetModel();
}
