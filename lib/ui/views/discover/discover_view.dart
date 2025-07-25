import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_enums.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/ui/views/discover/widgets/people_card.dart';
import 'package:nest/ui/views/discover/widgets/selector_widget.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_inputdecoration.dart';
import '../../common/app_styles.dart';
import 'discover_viewmodel.dart';

class DiscoverView extends StackedView<DiscoverViewModel> {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DiscoverViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Nest",
                      style: titleTextMedium.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: kcWhiteColor,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(search),
                        horizontalSpaceMedium,
                        SvgPicture.asset(notification),
                      ],
                    )
                  ],
                ),
                verticalSpaceMedium,
                TextFormField(
                  decoration: AppInputDecoration.search(
                    hintText: 'Search people, organizations...',
                  ),
                ),
                verticalSpaceMedium,
                Text(
                  "Find People & Organizations",
                  style: titleTextMedium.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kcWhiteColor,
                  ),
                ),
                verticalSpaceMedium,
                Row(
                  children: DiscoverableType.values.map((type) {
                    return buildSelector(
                      label: type.name,
                      isSelected: viewModel.discoverableType == type,
                      onTap: () => viewModel.selectType(type),
                    );
                  }).toList(),
                ),
                verticalSpaceMedium,
                LayoutBuilder(builder: (context, constraints) {
                  return Column(
                    children: [
                      ...viewModel.people.asMap().entries.map((entry) {
                        final index = entry.key;
                        final person = entry.value;

                        return Column(
                          children: [
                            buildPeopleCard(
                              avatar: person.imageUrl ?? '',
                              name: person.name ?? 'Unknown',
                              role: person.role ?? 'No role',
                            ),
                            if (index < viewModel.people.length - 1)
                              verticalSpaceSmall,
                          ],
                        );
                      }).toList(),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  DiscoverViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      DiscoverViewModel();
}
