import 'package:flutter/material.dart';
import 'package:nest/models/profile.dart';
import 'package:nest/ui/views/following/following_view.dart';
import 'package:nest/ui/views/for_you/for_you_view.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/shared_preferences_service.dart';
import '../../common/app_enums.dart';
import '../upcoming/upcoming_view.dart';

class DiscoverViewModel extends BaseViewModel {
  int _currentIndex = 1;
  final PageController pageController = PageController(initialPage: 1);
  Profile? profile;
  ContentType contentType = ContentType.upcoming;
  getUser() {
    var user = locator<SharedPreferencesService>().getUserInfo();
    if(user == null) return;
    profile = Profile.fromJson(user);
    notifyListeners();
  }

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

  void setContentType(ContentType type)async {

    contentType = type;
    final pageMap = {
      ContentType.fyp: 0,
      ContentType.upcoming: 1,
      ContentType.following: 2,
    };
    goToPage(pageMap[type] ?? 1);
    await getUser();
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
