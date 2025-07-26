import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/event_activity.dart';
import '../../../services/global_service.dart';

class ProfileViewModel extends ReactiveViewModel {
  bool get isUser => true;
  final globalService = locator<GlobalService>();
  onEditProfile() {
    locator<NavigationService>().navigateTo(Routes.editProfileView);
  }

  final eventActivities = [
    EventActivity(
      userName: 'John Doe',
      userProfileImageUrl: avatar,
      timeAgo: '2 hours ago',
      isEditable: true,
      eventImageUrl: ev1,
      captionTitle: 'Night Groove Fest – What an amazing night!',
      captionDescription:
          "The energy was incredible. Can't wait for the next one!",
      hashtags: ['#Nightlife', '#MusicFest'],
      likedByUser: 'Jane Smith',
      likeCount: 123,
    ),
    EventActivity(
      userName: 'Jane Smith',
      userProfileImageUrl: avatar,
      timeAgo: '1 day ago',
      isEditable: false,
      eventImageUrl: ev2,
      captionTitle: 'Sunset Beats – A perfect evening!',
      captionDescription: "The sunset was breathtaking. Loved every moment!",
      hashtags: ['#Sunset', '#ChillVibes'],
      likedByUser: 'John Doe',
      likeCount: 98,
    ),
    EventActivity(
      userName: 'DJ Electro',
      userProfileImageUrl: avatar,
      timeAgo: '3 days ago',
      isEditable: true,
      eventImageUrl: ev3,
      captionTitle: 'Techno Vibes – Lost in the music!',
      captionDescription:
          "The beats were hypnotic. Can't wait for the next set!",
      hashtags: ['#Techno', '#Rave'],
      likedByUser: 'Luna Beats',
      likeCount: 150,
    ),
    EventActivity(
      userName: 'Luna Beats',
      userProfileImageUrl: avatar,
      timeAgo: '5 days ago',
      isEditable: false,
      eventImageUrl: ev4,
      captionTitle: 'House Party – A night to remember!',
      captionDescription: "The house beats were on point. Loved the vibe!",
      hashtags: ['#HouseMusic', '#Party'],
      likedByUser: 'DJ Electro',
      likeCount: 200,
    ),
    EventActivity(
      userName: 'Event Masters Inc.',
      userProfileImageUrl: avatar,
      timeAgo: '1 week ago',
      isEditable: true,
      eventImageUrl: ev5,
      captionTitle: 'Festival Highlights – What a show!',
      captionDescription:
          "The performances were top-notch. Can't wait for next year!",
      hashtags: ['#Festival', '#Highlights'],
      likedByUser: 'The Warehouse',
      likeCount: 300,
    ),
    EventActivity(
      userName: 'The Warehouse',
      userProfileImageUrl: avatar,
      timeAgo: '2 weeks ago',
      isEditable: false,
      eventImageUrl: ev6,
      captionTitle: 'Warehouse Rave – An unforgettable night!',
      captionDescription: "The atmosphere was electric. Loved every beat!",
      hashtags: ['#Rave', '#Warehouse'],
      likedByUser: 'Event Masters Inc.',
      likeCount: 250,
    ),
  ];

  void handleEventTap(EventActivity selected) {
    final reorderedList = [
      selected,
      ...eventActivities.where((e) => e != selected),
    ];
    locator<NavigationService>().navigateTo(
      Routes.eventActivityView,
      arguments: EventActivityViewArguments(
        eventActivities: reorderedList,
      ),
    );
  }

  void goToChatView() {
    globalService.setIndex = 2; // Assuming index 2 is for messages
  }

  cretePost() {
    locator<NavigationService>().navigateTo(Routes.createPostView);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [globalService];
}
