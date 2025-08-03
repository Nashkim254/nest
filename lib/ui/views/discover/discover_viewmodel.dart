import 'package:nest/models/people_model.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';

import '../../../models/feed_post.dart';
import '../../common/app_enums.dart';

class DiscoverViewModel extends BaseViewModel {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  final List<FeedPost> _posts = [
    FeedPost(
      id: '1',
      username: 'DJ Groove',
      userAvatar: avatar,
      description: 'Dropping some fresh beats at the Electric Pulse event!',
      venue: '@warehouseX',
      hashtags: '#DJLife #ElectronicMusic #ElectricPulse',
      timeAgo: '5 hours ago',
      likes: 2500,
      comments: 512,
      shares: 150,
      videoUrl: 'assets/videos/dj_performance.mp4',
    ),
    // Add more posts as needed
  ];

  List<FeedPost> get posts => _posts;

  void onPageChanged(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void toggleLike(String postId) {
    // Implementation for like toggle
    notifyListeners();
  }

  void toggleFollow(String postId) {
    // Implementation for follow toggle
    notifyListeners();
  }

  void openComments(String postId) {
    // Implementation for opening comments
  }

  void sharePost(String postId) {
    // Implementation for sharing post
  }
}
