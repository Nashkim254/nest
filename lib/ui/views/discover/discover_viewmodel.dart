import 'package:nest/models/people_model.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

import '../../../models/feed_post.dart';
import '../../common/app_enums.dart';

class DiscoverViewModel extends BaseViewModel {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  String? _currentVideoUrl;

  VideoPlayerController? get controller => _controller;
  bool get isInitialized => _isInitialized;

  Future<void> initializeVideo(String videoUrl) async {
    if (_currentVideoUrl == videoUrl && _controller != null) return;

    await disposeVideo();

    _currentVideoUrl = videoUrl;
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));

    try {
      await _controller!.initialize();
      _isInitialized = true;
      _controller!.setLooping(true);
      notifyListeners();
    } catch (e) {
      _isInitialized = false;
      notifyListeners();
    }
  }

  void playVideo() {
    if (_controller != null && _isInitialized) {
      _controller!.play();
    }
  }

  void pauseVideo() {
    if (_controller != null && _isInitialized) {
      _controller!.pause();
    }
  }

  void togglePlayPause() {
    if (_controller != null && _isInitialized) {
      if (_controller!.value.isPlaying) {
        pauseVideo();
      } else {
        playVideo();
      }
    }
  }

  Future<void> disposeVideo() async {
    if (_controller != null) {
      await _controller!.dispose();
      _controller = null;
      _isInitialized = false;
      _currentVideoUrl = null;
    }
  }

  @override
  void dispose() {
    disposeVideo();
    super.dispose();
  }

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
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
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
  ContentType contentType = ContentType.fyp;
  void setContentType(ContentType type) {
    contentType = type;
    notifyListeners();
  }
}
