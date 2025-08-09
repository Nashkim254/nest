import 'package:flutter/material.dart';
import 'package:nest/ui/views/following/following_view.dart';
import 'package:nest/ui/views/for_you/for_you_view.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_enums.dart';
import '../upcoming/upcoming_view.dart';

class DiscoverViewModel extends BaseViewModel {
  late PageController pageController;

  void init() {
    pageController = PageController(initialPage: _currentIndex);
  }
  void goToPage(int index) {
    _currentIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  ContentType contentType = ContentType.upcoming;
  void setContentType(ContentType type) {
    contentType = type;
    notifyListeners();
  }

  int _currentIndex = 1;
  int get currentIndex => _currentIndex;
  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  List tabPages = [
    const ForYouView(),
    const UpcomingView(),
    const FollowingView(),
  ];
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
