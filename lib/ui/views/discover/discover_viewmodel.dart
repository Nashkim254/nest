import 'package:nest/app/app.locator.dart';
import 'package:nest/models/people_model.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_player/video_player.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.dialogs.dart';
import '../../../models/feed_post.dart';
import '../../common/app_enums.dart';

class DiscoverViewModel extends BaseViewModel {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  String? _currentVideoUrl;
  final dialogService = locator<DialogService>();
  final bottomSheet = locator<BottomSheetService>();
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
      description: 'Dropping some fresh beats at the Electric Pulse event! 🎵',
      venue: '@warehouseX',
      hashtags: '#DJLife #ElectronicMusic #ElectricPulse',
      timeAgo: '5 hours ago',
      likes: 2500,
      comments: 512,
      shares: 150,
      reposts: 120,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    ),
    FeedPost(
      id: '2',
      username: 'DreamMaker',
      userAvatar: avatar,
      description: 'Surreal visuals that take you to another dimension ✨',
      venue: '@digitalArena',
      hashtags: '#Dreams #Animation #DigitalArt',
      timeAgo: '8 hours ago',
      likes: 1800,
      comments: 324,
      reposts: 120,
      shares: 89,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    ),
    FeedPost(
      id: '3',
      username: 'FireStarter',
      userAvatar: avatar,
      description: 'When the beat drops and the crowd goes wild! 🔥',
      venue: '@blazeClub',
      hashtags: '#Fire #EDM #BeatDrop #NightLife',
      timeAgo: '12 hours ago',
      likes: 3200,
      comments: 678,
      shares: 234,
      reposts: 120,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    ),
    FeedPost(
      id: '4',
      username: 'EscapeArtist',
      userAvatar: avatar,
      description: 'Sometimes you need to escape reality and just vibe 🌅',
      venue: '@sunsetLounge',
      hashtags: '#Escape #Chill #Vibes #Sunset',
      timeAgo: '1 day ago',
      likes: 1450,
      comments: 287,
      shares: 156,
      reposts: 120,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    ),
    FeedPost(
      id: '5',
      username: 'FunMaster',
      userAvatar: avatar,
      description: 'Life is too short not to have fun! Let\'s party 🎉',
      venue: '@funZone',
      hashtags: '#Fun #Party #GoodVibes #Dance',
      timeAgo: '1 day ago',
      likes: 2100,
      comments: 445,
      shares: 198,
      reposts: 120,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    ),
    FeedPost(
      id: '6',
      username: 'RideOrDie',
      userAvatar: avatar,
      description: 'Taking you on the ultimate musical joyride 🏎️',
      venue: '@speedwayClub',
      hashtags: '#Joyride #Speed #Adrenaline #Music',
      timeAgo: '2 days ago',
      likes: 1750,
      comments: 356,
      shares: 127,
      reposts: 120,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    ),
    FeedPost(
      id: '7',
      username: 'MeltdownMix',
      userAvatar: avatar,
      description: 'When the bass hits so hard it causes a meltdown 🎛️',
      venue: '@undergroundVault',
      hashtags: '#Meltdown #Bass #Underground #Techno',
      timeAgo: '2 days ago',
      likes: 2800,
      comments: 567,
      shares: 289,
      reposts: 120,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
    ),
    FeedPost(
      id: '8',
      username: 'SintelSounds',
      userAvatar: avatar,
      description: 'Cinematic beats that tell a story without words 🎬',
      venue: '@cinemaClub',
      hashtags: '#Cinematic #Story #Ambient #Soundtrack',
      timeAgo: '3 days ago',
      likes: 1200,
      comments: 234,
      shares: 78,
      reposts: 120,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
    ),
    FeedPost(
      id: '9',
      username: 'StreetBeats',
      userAvatar: avatar,
      description: 'From the streets to the stage - raw and unfiltered 🚗',
      venue: '@streetSounds',
      hashtags: '#Street #Raw #Unfiltered #Urban',
      timeAgo: '3 days ago',
      likes: 1650,
      comments: 298,
      shares: 145,
      reposts: 120,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4',
    ),
    FeedPost(
      id: '10',
      username: 'SteelSymphony',
      userAvatar: avatar,
      description: 'Industrial sounds that forge the future of music ⚙️',
      venue: '@industrialForge',
      hashtags: '#Industrial #Steel #Future #Electronic',
      timeAgo: '4 days ago',
      likes: 1980,
      comments: 423,
      shares: 167,
      reposts: 120,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
    ),
    FeedPost(
      id: '11',
      username: 'BullrunBass',
      userAvatar: avatar,
      description: 'Going on a musical bull run - hold tight! 🐂',
      venue: '@stockExchangeClub',
      hashtags: '#Bullrun #Finance #Trading #ElectroSwing',
      timeAgo: '4 days ago',
      likes: 2250,
      comments: 478,
      shares: 201,
      reposts: 120,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4',
    ),
    FeedPost(
      id: '12',
      username: 'BudgetBeats',
      userAvatar: avatar,
      description: 'Quality music doesn\'t have to cost a fortune 💰',
      venue: '@budgetStudio',
      hashtags: '#Budget #Quality #Affordable #Music',
      timeAgo: '5 days ago',
      likes: 1350,
      comments: 267,
      shares: 93,
      reposts: 120,
      videoUrl:
          'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4',
    ),
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
    final result = dialogService.showCustomDialog(
      variant: DialogType.comments,
      title: 'Comments',
      data: postId,
    );
    result.then((value) {
      if (value != null && value.confirmed) {}
    });
    notifyListeners();
  }

  void sharePost(String postId) {
    final result = bottomSheet.showCustomSheet(
      variant: BottomSheetType.share,
      title: 'Share',
      data: postId,
    );
    result.then((value) {
      if (value != null && value.confirmed) {}
    });
  }

  void repost(String postId) {
    // Implementation for sharing post
  }
  ContentType contentType = ContentType.fyp;
  void setContentType(ContentType type) {
    contentType = type;
    notifyListeners();
  }
}
