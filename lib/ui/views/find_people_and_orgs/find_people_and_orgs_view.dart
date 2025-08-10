import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/views/find_people_and_orgs/widgets/top_selecto.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/app_inputdecoration.dart';
import '../../common/app_strings.dart';
import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import 'find_people_and_orgs_viewmodel.dart';

class FindPeopleAndOrgsView extends StackedView<FindPeopleAndOrgsViewModel> {
  const FindPeopleAndOrgsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FindPeopleAndOrgsViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kcDarkColor,
          title: Text(
            "My Nest",
            style: titleTextMedium.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
          ),
          elevation: 0,
          actions: [
            InkWell(
              onTap: () {
                // Handle search action
              },
              child: SvgPicture.asset(notification),
            ),
            horizontalSpaceSmall,
            const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage(avatar),
            ),
          ],
        ),
        backgroundColor: kcDarkColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                verticalSpaceMedium,
                // Search bar
                TextFormField(
                  controller: viewModel.searchController,
                  decoration: AppInputDecoration.search(
                    hintText: 'Search people, organizations...',
                  ),
                ),
                verticalSpaceMedium,
                Text(
                  'Find People & Organizations',
                  style: titleTextMedium.copyWith(
                    fontSize: 18,
                  ),
                ),
                verticalSpaceMedium,
                const FindTabBarWidget(),
                verticalSpaceMedium,
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kcContainerColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: const CircleAvatar(
                            radius: 24,
                            backgroundImage: AssetImage(avatar),
                          ),
                          title: Text(
                            'DJ Electro',
                            style: titleTextMedium.copyWith(
                              fontSize: 16,
                              color: kcWhiteColor,
                            ),
                          ),
                          subtitle: Text(
                            'Artist / Techno',
                            style: titleTextMedium.copyWith(
                              color: kcGreyColor,
                            ),
                          ),
                          trailing: AppButton(
                              width: 75, labelText: 'Follow', onTap: () {}),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  FindPeopleAndOrgsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FindPeopleAndOrgsViewModel();
}
