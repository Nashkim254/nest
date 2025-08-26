import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/views/discover/discover_view.dart';
import 'package:nest/ui/views/hosting/hosting_view.dart';
import 'package:nest/ui/views/messages/messages_view.dart';
import 'package:nest/ui/views/tickets/tickets_view.dart';

import '../../../app/app.locator.dart';
import '../../../models/page_item_model.dart';
import '../../../services/global_service.dart';
import '../profile/profile_view.dart';

List<PageItem> tabPages({
  required BuildContext context,
  required Function onPageChange,
}) =>
    [
      PageItem(
        page: const DiscoverView(),
        bottomNavigationBarItem: customBottomNavigationBarItem(
          assetUrl: discover,
          label: "Discover",
          currentIndex: 0,
        ),
      ),
      PageItem(
        page: const HostingView(),
        bottomNavigationBarItem: customBottomNavigationBarItem(
          assetUrl: hosting,
          label: "Hosting",
          currentIndex: 1,
        ),
      ),
      PageItem(
        page: const MessagesView(),
        bottomNavigationBarItem: customBottomNavigationBarItem(
          assetUrl: messages,
          label: "Messages",
          currentIndex: 2,
        ),
      ),
      PageItem(
        page: const TicketsView(),
        bottomNavigationBarItem: customBottomNavigationBarItem(
          assetUrl: tickets,
          label: "Tickets",
          currentIndex: 3,
        ),
      ),
      PageItem(
        page: const ProfileView(isOtherUser: false),
        bottomNavigationBarItem: customBottomNavigationBarItem(
          assetUrl: profile,
          label: "Profile",
          currentIndex: 4,
        ),
      ),
    ];
BottomNavigationBarItem customBottomNavigationBarItem({
  required String assetUrl,
  required String label,
  required int currentIndex,
  String? userPhoto,
}) {
  final int selectedIndex = locator<GlobalService>().selectedHomeTabIndex;
  return BottomNavigationBarItem(
    activeIcon: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        SvgPicture.asset(
          assetUrl,
          height: 24,
          width: 24,
          colorFilter: const ColorFilter.mode(
            kcPrimaryColor,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 4),
      ],
    ),
    icon: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        SvgPicture.asset(
          assetUrl,
          height: 24,
          width: 24,
          colorFilter: ColorFilter.mode(
            currentIndex == selectedIndex ? kcPrimaryColor : kcUnselectedColor,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 4),
      ],
    ),
    label: label,
  );
}
