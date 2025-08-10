import 'package:flutter/material.dart';
import 'package:nest/ui/views/following/following_view.dart';
import 'package:nest/ui/views/for_you/for_you_view.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_enums.dart';
import '../upcoming/upcoming_view.dart';

class DiscoverViewModel extends BaseViewModel {
  int _currentIndex = 1;
  final PageController pageController = PageController(initialPage: 1);

  ContentType contentType = ContentType.upcoming;

  void goToPage(int index) {
    _currentIndex = index;

    // Make sure controller is attached
    if (pageController.hasClients) {
      pageController.jumpToPage(index);
    } else {
      // Wait until the frame is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (pageController.hasClients) {
          pageController.jumpToPage(index);
        }
      });
    }
    notifyListeners();
  }

  void setContentType(ContentType type) {
    contentType = type;
    final pageMap = {
      ContentType.fyp: 0,
      ContentType.upcoming: 1,
      ContentType.following: 2,
    };
    goToPage(pageMap[type] ?? 1);
  }

  int get currentIndex => _currentIndex;

  void onPageChanged(int index) {
    _currentIndex = index;
    final contentMap = {
      0: ContentType.fyp,
      1: ContentType.upcoming,
      2: ContentType.following,
    };
    contentType = contentMap[index] ?? ContentType.upcoming;
    notifyListeners();
  }

  final List<Widget> tabPages = const [
    ForYouView(),
    UpcomingView(),
    FollowingView(),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
