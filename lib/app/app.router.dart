// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as _i28;
import 'package:nest/models/chats.dart' as _i31;
import 'package:nest/models/event_activity.dart' as _i30;
import 'package:nest/models/events.dart' as _i32;
import 'package:nest/models/registration_model.dart' as _i29;
import 'package:nest/ui/views/chat/chat_view.dart' as _i16;
import 'package:nest/ui/views/create_event/create_event_view.dart' as _i19;
import 'package:nest/ui/views/create_organization/create_organization_view.dart'
    as _i27;
import 'package:nest/ui/views/create_post/create_post_view.dart' as _i17;
import 'package:nest/ui/views/discover/discover_view.dart' as _i8;
import 'package:nest/ui/views/discover_find_people/discover_find_people_view.dart'
    as _i18;
import 'package:nest/ui/views/edit_profile/edit_profile_view.dart' as _i14;
import 'package:nest/ui/views/event_activity/event_activity_view.dart' as _i15;
import 'package:nest/ui/views/explore_events/explore_events_view.dart' as _i23;
import 'package:nest/ui/views/find_people_and_orgs/find_people_and_orgs_view.dart'
    as _i24;
import 'package:nest/ui/views/following/following_view.dart' as _i22;
import 'package:nest/ui/views/for_you/for_you_view.dart' as _i21;
import 'package:nest/ui/views/home/home_view.dart' as _i2;
import 'package:nest/ui/views/hosting/hosting_view.dart' as _i9;
import 'package:nest/ui/views/interest_selection/interest_selection_view.dart'
    as _i4;
import 'package:nest/ui/views/location/location_view.dart' as _i5;
import 'package:nest/ui/views/login/login_view.dart' as _i6;
import 'package:nest/ui/views/messages/messages_view.dart' as _i10;
import 'package:nest/ui/views/navigation/navigation_view.dart' as _i13;
import 'package:nest/ui/views/profile/profile_view.dart' as _i12;
import 'package:nest/ui/views/register/register_view.dart' as _i7;
import 'package:nest/ui/views/settings/settings_view.dart' as _i26;
import 'package:nest/ui/views/startup/startup_view.dart' as _i3;
import 'package:nest/ui/views/tickets/tickets_view.dart' as _i11;
import 'package:nest/ui/views/upcoming/upcoming_view.dart' as _i20;
import 'package:nest/ui/views/view_event/view_event_view.dart' as _i25;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i33;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const interestSelectionView = '/interest-selection-view';

  static const locationView = '/location-view';

  static const loginView = '/login-view';

  static const registerView = '/register-view';

  static const discoverView = '/discover-view';

  static const hostingView = '/hosting-view';

  static const messagesView = '/messages-view';

  static const ticketsView = '/tickets-view';

  static const profileView = '/profile-view';

  static const navigationView = '/navigation-view';

  static const editProfileView = '/edit-profile-view';

  static const eventActivityView = '/event-activity-view';

  static const chatView = '/chat-view';

  static const createPostView = '/create-post-view';

  static const discoverFindPeopleView = '/discover-find-people-view';

  static const createEventView = '/create-event-view';

  static const upcomingView = '/upcoming-view';

  static const forYouView = '/for-you-view';

  static const followingView = '/following-view';

  static const exploreEventsView = '/explore-events-view';

  static const findPeopleAndOrgsView = '/find-people-and-orgs-view';

  static const viewEventView = '/view-event-view';

  static const settingsView = '/settings-view';

  static const createOrganizationView = '/create-organization-view';

  static const all = <String>{
    homeView,
    startupView,
    interestSelectionView,
    locationView,
    loginView,
    registerView,
    discoverView,
    hostingView,
    messagesView,
    ticketsView,
    profileView,
    navigationView,
    editProfileView,
    eventActivityView,
    chatView,
    createPostView,
    discoverFindPeopleView,
    createEventView,
    upcomingView,
    forYouView,
    followingView,
    exploreEventsView,
    findPeopleAndOrgsView,
    viewEventView,
    settingsView,
    createOrganizationView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.interestSelectionView,
      page: _i4.InterestSelectionView,
    ),
    _i1.RouteDef(
      Routes.locationView,
      page: _i5.LocationView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i6.LoginView,
    ),
    _i1.RouteDef(
      Routes.registerView,
      page: _i7.RegisterView,
    ),
    _i1.RouteDef(
      Routes.discoverView,
      page: _i8.DiscoverView,
    ),
    _i1.RouteDef(
      Routes.hostingView,
      page: _i9.HostingView,
    ),
    _i1.RouteDef(
      Routes.messagesView,
      page: _i10.MessagesView,
    ),
    _i1.RouteDef(
      Routes.ticketsView,
      page: _i11.TicketsView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i12.ProfileView,
    ),
    _i1.RouteDef(
      Routes.navigationView,
      page: _i13.NavigationView,
    ),
    _i1.RouteDef(
      Routes.editProfileView,
      page: _i14.EditProfileView,
    ),
    _i1.RouteDef(
      Routes.eventActivityView,
      page: _i15.EventActivityView,
    ),
    _i1.RouteDef(
      Routes.chatView,
      page: _i16.ChatView,
    ),
    _i1.RouteDef(
      Routes.createPostView,
      page: _i17.CreatePostView,
    ),
    _i1.RouteDef(
      Routes.discoverFindPeopleView,
      page: _i18.DiscoverFindPeopleView,
    ),
    _i1.RouteDef(
      Routes.createEventView,
      page: _i19.CreateEventView,
    ),
    _i1.RouteDef(
      Routes.upcomingView,
      page: _i20.UpcomingView,
    ),
    _i1.RouteDef(
      Routes.forYouView,
      page: _i21.ForYouView,
    ),
    _i1.RouteDef(
      Routes.followingView,
      page: _i22.FollowingView,
    ),
    _i1.RouteDef(
      Routes.exploreEventsView,
      page: _i23.ExploreEventsView,
    ),
    _i1.RouteDef(
      Routes.findPeopleAndOrgsView,
      page: _i24.FindPeopleAndOrgsView,
    ),
    _i1.RouteDef(
      Routes.viewEventView,
      page: _i25.ViewEventView,
    ),
    _i1.RouteDef(
      Routes.settingsView,
      page: _i26.SettingsView,
    ),
    _i1.RouteDef(
      Routes.createOrganizationView,
      page: _i27.CreateOrganizationView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.InterestSelectionView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.InterestSelectionView(),
        settings: data,
      );
    },
    _i5.LocationView: (data) {
      final args = data.getArgs<LocationViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.LocationView(
            key: args.key, registrationModel: args.registrationModel),
        settings: data,
      );
    },
    _i6.LoginView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.LoginView(),
        settings: data,
      );
    },
    _i7.RegisterView: (data) {
      final args = data.getArgs<RegisterViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.RegisterView(
            key: args.key, registrationModel: args.registrationModel),
        settings: data,
      );
    },
    _i8.DiscoverView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.DiscoverView(),
        settings: data,
      );
    },
    _i9.HostingView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.HostingView(),
        settings: data,
      );
    },
    _i10.MessagesView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.MessagesView(),
        settings: data,
      );
    },
    _i11.TicketsView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.TicketsView(),
        settings: data,
      );
    },
    _i12.ProfileView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.ProfileView(),
        settings: data,
      );
    },
    _i13.NavigationView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.NavigationView(),
        settings: data,
      );
    },
    _i14.EditProfileView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.EditProfileView(),
        settings: data,
      );
    },
    _i15.EventActivityView: (data) {
      final args = data.getArgs<EventActivityViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.EventActivityView(
            key: args.key, eventActivities: args.eventActivities),
        settings: data,
      );
    },
    _i16.ChatView: (data) {
      final args = data.getArgs<ChatViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => _i16.ChatView(key: args.key, chat: args.chat),
        settings: data,
      );
    },
    _i17.CreatePostView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i17.CreatePostView(),
        settings: data,
      );
    },
    _i18.DiscoverFindPeopleView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i18.DiscoverFindPeopleView(),
        settings: data,
      );
    },
    _i19.CreateEventView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i19.CreateEventView(),
        settings: data,
      );
    },
    _i20.UpcomingView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i20.UpcomingView(),
        settings: data,
      );
    },
    _i21.ForYouView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i21.ForYouView(),
        settings: data,
      );
    },
    _i22.FollowingView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i22.FollowingView(),
        settings: data,
      );
    },
    _i23.ExploreEventsView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i23.ExploreEventsView(),
        settings: data,
      );
    },
    _i24.FindPeopleAndOrgsView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i24.FindPeopleAndOrgsView(),
        settings: data,
      );
    },
    _i25.ViewEventView: (data) {
      final args = data.getArgs<ViewEventViewArguments>(nullOk: false);
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i25.ViewEventView(key: args.key, event: args.event),
        settings: data,
      );
    },
    _i26.SettingsView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i26.SettingsView(),
        settings: data,
      );
    },
    _i27.CreateOrganizationView: (data) {
      return _i28.MaterialPageRoute<dynamic>(
        builder: (context) => const _i27.CreateOrganizationView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class LocationViewArguments {
  const LocationViewArguments({
    this.key,
    required this.registrationModel,
  });

  final _i28.Key? key;

  final _i29.RegistrationModel registrationModel;

  @override
  String toString() {
    return '{"key": "$key", "registrationModel": "$registrationModel"}';
  }

  @override
  bool operator ==(covariant LocationViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.registrationModel == registrationModel;
  }

  @override
  int get hashCode {
    return key.hashCode ^ registrationModel.hashCode;
  }
}

class RegisterViewArguments {
  const RegisterViewArguments({
    this.key,
    required this.registrationModel,
  });

  final _i28.Key? key;

  final _i29.RegistrationModel registrationModel;

  @override
  String toString() {
    return '{"key": "$key", "registrationModel": "$registrationModel"}';
  }

  @override
  bool operator ==(covariant RegisterViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.registrationModel == registrationModel;
  }

  @override
  int get hashCode {
    return key.hashCode ^ registrationModel.hashCode;
  }
}

class EventActivityViewArguments {
  const EventActivityViewArguments({
    this.key,
    required this.eventActivities,
  });

  final _i28.Key? key;

  final List<_i30.EventActivity> eventActivities;

  @override
  String toString() {
    return '{"key": "$key", "eventActivities": "$eventActivities"}';
  }

  @override
  bool operator ==(covariant EventActivityViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.eventActivities == eventActivities;
  }

  @override
  int get hashCode {
    return key.hashCode ^ eventActivities.hashCode;
  }
}

class ChatViewArguments {
  const ChatViewArguments({
    this.key,
    required this.chat,
  });

  final _i28.Key? key;

  final _i31.Chats chat;

  @override
  String toString() {
    return '{"key": "$key", "chat": "$chat"}';
  }

  @override
  bool operator ==(covariant ChatViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.chat == chat;
  }

  @override
  int get hashCode {
    return key.hashCode ^ chat.hashCode;
  }
}

class ViewEventViewArguments {
  const ViewEventViewArguments({
    this.key,
    required this.event,
  });

  final _i28.Key? key;

  final _i32.Event event;

  @override
  String toString() {
    return '{"key": "$key", "event": "$event"}';
  }

  @override
  bool operator ==(covariant ViewEventViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.event == event;
  }

  @override
  int get hashCode {
    return key.hashCode ^ event.hashCode;
  }
}

extension NavigatorStateExtension on _i33.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToInterestSelectionView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.interestSelectionView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLocationView({
    _i28.Key? key,
    required _i29.RegistrationModel registrationModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.locationView,
        arguments: LocationViewArguments(
            key: key, registrationModel: registrationModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterView({
    _i28.Key? key,
    required _i29.RegistrationModel registrationModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.registerView,
        arguments: RegisterViewArguments(
            key: key, registrationModel: registrationModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDiscoverView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.discoverView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHostingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.hostingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMessagesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.messagesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTicketsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.ticketsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNavigationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.navigationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.editProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEventActivityView({
    _i28.Key? key,
    required List<_i30.EventActivity> eventActivities,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.eventActivityView,
        arguments: EventActivityViewArguments(
            key: key, eventActivities: eventActivities),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChatView({
    _i28.Key? key,
    required _i31.Chats chat,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.chatView,
        arguments: ChatViewArguments(key: key, chat: chat),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreatePostView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.createPostView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDiscoverFindPeopleView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.discoverFindPeopleView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateEventView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.createEventView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToUpcomingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.upcomingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToForYouView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.forYouView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFollowingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.followingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExploreEventsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.exploreEventsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFindPeopleAndOrgsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.findPeopleAndOrgsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToViewEventView({
    _i28.Key? key,
    required _i32.Event event,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.viewEventView,
        arguments: ViewEventViewArguments(key: key, event: event),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateOrganizationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.createOrganizationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithInterestSelectionView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.interestSelectionView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLocationView({
    _i28.Key? key,
    required _i29.RegistrationModel registrationModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.locationView,
        arguments: LocationViewArguments(
            key: key, registrationModel: registrationModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterView({
    _i28.Key? key,
    required _i29.RegistrationModel registrationModel,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.registerView,
        arguments: RegisterViewArguments(
            key: key, registrationModel: registrationModel),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDiscoverView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.discoverView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHostingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.hostingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMessagesView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.messagesView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTicketsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.ticketsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNavigationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.navigationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.editProfileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEventActivityView({
    _i28.Key? key,
    required List<_i30.EventActivity> eventActivities,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.eventActivityView,
        arguments: EventActivityViewArguments(
            key: key, eventActivities: eventActivities),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChatView({
    _i28.Key? key,
    required _i31.Chats chat,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.chatView,
        arguments: ChatViewArguments(key: key, chat: chat),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreatePostView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.createPostView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDiscoverFindPeopleView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.discoverFindPeopleView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateEventView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.createEventView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithUpcomingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.upcomingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithForYouView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.forYouView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFollowingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.followingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExploreEventsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.exploreEventsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFindPeopleAndOrgsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.findPeopleAndOrgsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithViewEventView({
    _i28.Key? key,
    required _i32.Event event,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.viewEventView,
        arguments: ViewEventViewArguments(key: key, event: event),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateOrganizationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.createOrganizationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
