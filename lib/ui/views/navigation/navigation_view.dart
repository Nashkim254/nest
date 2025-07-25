import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/views/navigation/tab_widget.dart';
import 'package:stacked/stacked.dart';

import 'navigation_viewmodel.dart';

class NavigationView extends StackedView<NavigationViewModel> {
  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    NavigationViewModel viewModel,
    Widget? child,
  ) {
    return PopScope(
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
        backgroundColor: kcDarkColor,
        body: tabPages(
          context: context,
          onPageChange: viewModel.setSelectedHomeTabIndex,
        ).map((e) => e.page).toList()[viewModel.selectedHomeTabIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 15,
          backgroundColor: kcDarkColor,
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 10,
          unselectedItemColor: kcUnselectedColor,
          selectedItemColor: kcPrimaryColor,
          unselectedIconTheme: const IconThemeData(
            color: kcUnselectedColor,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 12,
            letterSpacing: -0.005,
            fontWeight: FontWeight.w400,
            color: kcUnselectedColor,
          ),
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            letterSpacing: -0.005,
            fontWeight: FontWeight.w500,
            color: kcPrimaryColor,
          ),
          currentIndex: viewModel.selectedHomeTabIndex,
          items: tabPages(
            context: context,
            onPageChange: viewModel.setSelectedHomeTabIndex,
          ).map((e) => e.bottomNavigationBarItem).toList(),
          onTap: (index) {
            viewModel.setSelectedHomeTabIndex(index);
          },
        ),
      ),
    );
  }

  @override
  NavigationViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      NavigationViewModel();
}
