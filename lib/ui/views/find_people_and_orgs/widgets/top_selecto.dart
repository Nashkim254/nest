import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_enums.dart';
import '../find_people_and_orgs_viewmodel.dart';

class FindTabBarWidget extends ViewModelWidget<FindPeopleAndOrgsViewModel> {
  const FindTabBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, FindPeopleAndOrgsViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTabItem(
            'All',
            viewModel.finderType == FinderType.all,
            onPressed: () => viewModel.setFinderType(FinderType.all),
          ),
          const SizedBox(width: 32),
          _buildTabItem(
            'People',
            viewModel.finderType == FinderType.people,
            onPressed: () => viewModel.setFinderType(FinderType.people),
          ),
          const SizedBox(width: 32),
          _buildTabItem(
            'Organizations',
            viewModel.finderType == FinderType.organizations,
            onPressed: () => viewModel.setFinderType(FinderType.organizations),
          ),
        ],
      ),
    );
  }
}

Widget _buildTabItem(String title, bool isActive, {VoidCallback? onPressed}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? kcPrimaryColor : kcOffGreyColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : kcGreyColor,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    ),
  );
}
