// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i35;
import 'package:flutter/material.dart';
import 'package:nest/models/events.dart' as _i39;
import 'package:nest/models/message_models.dart' as _i37;
import 'package:nest/models/organization_model.dart' as _i40;
import 'package:nest/models/registration_model.dart' as _i36;
import 'package:nest/models/user_serach_ressult.dart' as _i38;
import 'package:nest/ui/views/analytics/analytics_view.dart' as _i30;
import 'package:nest/ui/views/chat/chat_view.dart' as _i16;
import 'package:nest/ui/views/checkout/checkout_view.dart' as _i28;
import 'package:nest/ui/views/create_event/create_event_view.dart' as _i19;
import 'package:nest/ui/views/create_organization/create_organization_view.dart'
    as _i27;
import 'package:nest/ui/views/create_post/create_post_view.dart' as _i17;
import 'package:nest/ui/views/discover/discover_view.dart' as _i8;
import 'package:nest/ui/views/discover_find_people/discover_find_people_view.dart'
    as _i18;
import 'package:nest/ui/views/edit_event/edit_event_view.dart' as _i34;
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
import 'package:nest/ui/views/manage_events/manage_events_view.dart' as _i32;
import 'package:nest/ui/views/manage_team/manage_team_view.dart' as _i33;
import 'package:nest/ui/views/messages/messages_view.dart' as _i10;
import 'package:nest/ui/views/navigation/navigation_view.dart' as _i13;
import 'package:nest/ui/views/paymentweb/paymentweb_view.dart' as _i29;
import 'package:nest/ui/views/profile/profile_view.dart' as _i12;
import 'package:nest/ui/views/register/register_view.dart' as _i7;
import 'package:nest/ui/views/settings/settings_view.dart' as _i26;
import 'package:nest/ui/views/startup/startup_view.dart' as _i3;
import 'package:nest/ui/views/ticket_scanning/ticket_scanning_view.dart'
    as _i31;
import 'package:nest/ui/views/tickets/tickets_view.dart' as _i11;
import 'package:nest/ui/views/upcoming/upcoming_view.dart' as _i20;
import 'package:nest/ui/views/view_event/view_event_view.dart' as _i25;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i41;

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

  static const checkoutView = '/checkout-view';

  static const paymentwebView = '/paymentweb-view';

  static const analyticsView = '/analytics-view';

  static const ticketScanningView = '/ticket-scanning-view';

  static const manageEventsView = '/manage-events-view';

  static const manageTeamView = '/manage-team-view';

  static const editEventView = '/edit-event-view';

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
    checkoutView,
    paymentwebView,
    analyticsView,
    ticketScanningView,
    manageEventsView,
    manageTeamView,
    editEventView,
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
    _i1.RouteDef(
      Routes.checkoutView,
      page: _i28.CheckoutView,
    ),
    _i1.RouteDef(
      Routes.paymentwebView,
      page: _i29.PaymentwebView,
    ),
    _i1.RouteDef(
      Routes.analyticsView,
      page: _i30.AnalyticsView,
    ),
    _i1.RouteDef(
      Routes.ticketScanningView,
      page: _i31.TicketScanningView,
    ),
    _i1.RouteDef(
      Routes.manageEventsView,
      page: _i32.ManageEventsView,
    ),
    _i1.RouteDef(
      Routes.manageTeamView,
      page: _i33.ManageTeamView,
    ),
    _i1.RouteDef(
      Routes.editEventView,
      page: _i34.EditEventView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.InterestSelectionView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.InterestSelectionView(),
        settings: data,
      );
    },
    _i5.LocationView: (data) {
      final args = data.getArgs<LocationViewArguments>(nullOk: false);
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.LocationView(
            key: args.key, registrationModel: args.registrationModel),
        settings: data,
      );
    },
    _i6.LoginView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.LoginView(),
        settings: data,
      );
    },
    _i7.RegisterView: (data) {
      final args = data.getArgs<RegisterViewArguments>(nullOk: false);
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.RegisterView(
            key: args.key, registrationModel: args.registrationModel),
        settings: data,
      );
    },
    _i8.DiscoverView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.DiscoverView(),
        settings: data,
      );
    },
    _i9.HostingView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.HostingView(),
        settings: data,
      );
    },
    _i10.MessagesView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.MessagesView(),
        settings: data,
      );
    },
    _i11.TicketsView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.TicketsView(),
        settings: data,
      );
    },
    _i12.ProfileView: (data) {
      final args = data.getArgs<ProfileViewArguments>(nullOk: false);
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i12.ProfileView(key: args.key, isOtherUser: args.isOtherUser),
        settings: data,
      );
    },
    _i13.NavigationView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i13.NavigationView(),
        settings: data,
      );
    },
    _i14.EditProfileView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.EditProfileView(),
        settings: data,
      );
    },
    _i15.EventActivityView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.EventActivityView(),
        settings: data,
      );
    },
    _i16.ChatView: (data) {
      final args = data.getArgs<ChatViewArguments>(nullOk: false);
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i16.ChatView(key: args.key, chat: args.chat, user: args.user),
        settings: data,
      );
    },
    _i17.CreatePostView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i17.CreatePostView(),
        settings: data,
      );
    },
    _i18.DiscoverFindPeopleView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i18.DiscoverFindPeopleView(),
        settings: data,
      );
    },
    _i19.CreateEventView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i19.CreateEventView(),
        settings: data,
      );
    },
    _i20.UpcomingView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i20.UpcomingView(),
        settings: data,
      );
    },
    _i21.ForYouView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i21.ForYouView(),
        settings: data,
      );
    },
    _i22.FollowingView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i22.FollowingView(),
        settings: data,
      );
    },
    _i23.ExploreEventsView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i23.ExploreEventsView(),
        settings: data,
      );
    },
    _i24.FindPeopleAndOrgsView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i24.FindPeopleAndOrgsView(),
        settings: data,
      );
    },
    _i25.ViewEventView: (data) {
      final args = data.getArgs<ViewEventViewArguments>(nullOk: false);
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => _i25.ViewEventView(
            key: args.key, event: args.event, password: args.password),
        settings: data,
      );
    },
    _i26.SettingsView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i26.SettingsView(),
        settings: data,
      );
    },
    _i27.CreateOrganizationView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i27.CreateOrganizationView(),
        settings: data,
      );
    },
    _i28.CheckoutView: (data) {
      final args = data.getArgs<CheckoutViewArguments>(nullOk: false);
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i28.CheckoutView(key: args.key, ticketInfo: args.ticketInfo),
        settings: data,
      );
    },
    _i29.PaymentwebView: (data) {
      final args = data.getArgs<PaymentwebViewArguments>(nullOk: false);
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i29.PaymentwebView(key: args.key, checkoutURL: args.checkoutURL),
        settings: data,
      );
    },
    _i30.AnalyticsView: (data) {
      final args = data.getArgs<AnalyticsViewArguments>(nullOk: false);
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => _i30.AnalyticsView(
            key: args.key, organizationId: args.organizationId),
        settings: data,
      );
    },
    _i31.TicketScanningView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i31.TicketScanningView(),
        settings: data,
      );
    },
    _i32.ManageEventsView: (data) {
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) => const _i32.ManageEventsView(),
        settings: data,
      );
    },
    _i33.ManageTeamView: (data) {
      final args = data.getArgs<ManageTeamViewArguments>(nullOk: false);
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i33.ManageTeamView(key: args.key, organization: args.organization),
        settings: data,
      );
    },
    _i34.EditEventView: (data) {
      final args = data.getArgs<EditEventViewArguments>(nullOk: false);
      return _i35.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i34.EditEventView(key: args.key, event: args.event),
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

  final _i35.Key? key;

  final _i36.RegistrationModel registrationModel;

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

  final _i35.Key? key;

  final _i36.RegistrationModel registrationModel;

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

class ProfileViewArguments {
  const ProfileViewArguments({
    this.key,
    required this.isOtherUser,
  });

  final _i35.Key? key;

  final bool isOtherUser;

  @override
  String toString() {
    return '{"key": "$key", "isOtherUser": "$isOtherUser"}';
  }

  @override
  bool operator ==(covariant ProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.isOtherUser == isOtherUser;
  }

  @override
  int get hashCode {
    return key.hashCode ^ isOtherUser.hashCode;
  }
}

class ChatViewArguments {
  const ChatViewArguments({
    this.key,
    required this.chat,
    this.user,
  });

  final _i35.Key? key;

  final _i37.Conversation? chat;

  final _i38.UserSearchResult? user;

  @override
  String toString() {
    return '{"key": "$key", "chat": "$chat", "user": "$user"}';
  }

  @override
  bool operator ==(covariant ChatViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.chat == chat && other.user == user;
  }

  @override
  int get hashCode {
    return key.hashCode ^ chat.hashCode ^ user.hashCode;
  }
}

class ViewEventViewArguments {
  const ViewEventViewArguments({
    this.key,
    required this.event,
    this.password,
  });

  final _i35.Key? key;

  final _i39.Event event;

  final String? password;

  @override
  String toString() {
    return '{"key": "$key", "event": "$event", "password": "$password"}';
  }

  @override
  bool operator ==(covariant ViewEventViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.event == event &&
        other.password == password;
  }

  @override
  int get hashCode {
    return key.hashCode ^ event.hashCode ^ password.hashCode;
  }
}

class CheckoutViewArguments {
  const CheckoutViewArguments({
    this.key,
    required this.ticketInfo,
  });

  final _i35.Key? key;

  final Map<dynamic, dynamic> ticketInfo;

  @override
  String toString() {
    return '{"key": "$key", "ticketInfo": "$ticketInfo"}';
  }

  @override
  bool operator ==(covariant CheckoutViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.ticketInfo == ticketInfo;
  }

  @override
  int get hashCode {
    return key.hashCode ^ ticketInfo.hashCode;
  }
}

class PaymentwebViewArguments {
  const PaymentwebViewArguments({
    this.key,
    required this.checkoutURL,
  });

  final _i35.Key? key;

  final String checkoutURL;

  @override
  String toString() {
    return '{"key": "$key", "checkoutURL": "$checkoutURL"}';
  }

  @override
  bool operator ==(covariant PaymentwebViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.checkoutURL == checkoutURL;
  }

  @override
  int get hashCode {
    return key.hashCode ^ checkoutURL.hashCode;
  }
}

class AnalyticsViewArguments {
  const AnalyticsViewArguments({
    this.key,
    required this.organizationId,
  });

  final _i35.Key? key;

  final int organizationId;

  @override
  String toString() {
    return '{"key": "$key", "organizationId": "$organizationId"}';
  }

  @override
  bool operator ==(covariant AnalyticsViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.organizationId == organizationId;
  }

  @override
  int get hashCode {
    return key.hashCode ^ organizationId.hashCode;
  }
}

class ManageTeamViewArguments {
  const ManageTeamViewArguments({
    this.key,
    required this.organization,
  });

  final _i35.Key? key;

  final _i40.Organization organization;

  @override
  String toString() {
    return '{"key": "$key", "organization": "$organization"}';
  }

  @override
  bool operator ==(covariant ManageTeamViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.organization == organization;
  }

  @override
  int get hashCode {
    return key.hashCode ^ organization.hashCode;
  }
}

class EditEventViewArguments {
  const EditEventViewArguments({
    this.key,
    required this.event,
  });

  final _i35.Key? key;

  final _i39.Event event;

  @override
  String toString() {
    return '{"key": "$key", "event": "$event"}';
  }

  @override
  bool operator ==(covariant EditEventViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.event == event;
  }

  @override
  int get hashCode {
    return key.hashCode ^ event.hashCode;
  }
}

extension NavigatorStateExtension on _i41.NavigationService {
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
    _i35.Key? key,
    required _i36.RegistrationModel registrationModel,
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
    _i35.Key? key,
    required _i36.RegistrationModel registrationModel,
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

  Future<dynamic> navigateToProfileView({
    _i35.Key? key,
    required bool isOtherUser,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.profileView,
        arguments: ProfileViewArguments(key: key, isOtherUser: isOtherUser),
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

  Future<dynamic> navigateToEventActivityView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.eventActivityView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChatView({
    _i35.Key? key,
    required _i37.Conversation? chat,
    _i38.UserSearchResult? user,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.chatView,
        arguments: ChatViewArguments(key: key, chat: chat, user: user),
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
    _i35.Key? key,
    required _i39.Event event,
    String? password,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.viewEventView,
        arguments:
            ViewEventViewArguments(key: key, event: event, password: password),
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

  Future<dynamic> navigateToCheckoutView({
    _i35.Key? key,
    required Map<dynamic, dynamic> ticketInfo,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.checkoutView,
        arguments: CheckoutViewArguments(key: key, ticketInfo: ticketInfo),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPaymentwebView({
    _i35.Key? key,
    required String checkoutURL,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.paymentwebView,
        arguments: PaymentwebViewArguments(key: key, checkoutURL: checkoutURL),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAnalyticsView({
    _i35.Key? key,
    required int organizationId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.analyticsView,
        arguments:
            AnalyticsViewArguments(key: key, organizationId: organizationId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTicketScanningView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.ticketScanningView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToManageEventsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.manageEventsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToManageTeamView({
    _i35.Key? key,
    required _i40.Organization organization,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.manageTeamView,
        arguments:
            ManageTeamViewArguments(key: key, organization: organization),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditEventView({
    _i35.Key? key,
    required _i39.Event event,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.editEventView,
        arguments: EditEventViewArguments(key: key, event: event),
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
    _i35.Key? key,
    required _i36.RegistrationModel registrationModel,
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
    _i35.Key? key,
    required _i36.RegistrationModel registrationModel,
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

  Future<dynamic> replaceWithProfileView({
    _i35.Key? key,
    required bool isOtherUser,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.profileView,
        arguments: ProfileViewArguments(key: key, isOtherUser: isOtherUser),
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

  Future<dynamic> replaceWithEventActivityView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.eventActivityView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChatView({
    _i35.Key? key,
    required _i37.Conversation? chat,
    _i38.UserSearchResult? user,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.chatView,
        arguments: ChatViewArguments(key: key, chat: chat, user: user),
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
    _i35.Key? key,
    required _i39.Event event,
    String? password,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.viewEventView,
        arguments:
            ViewEventViewArguments(key: key, event: event, password: password),
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

  Future<dynamic> replaceWithCheckoutView({
    _i35.Key? key,
    required Map<dynamic, dynamic> ticketInfo,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.checkoutView,
        arguments: CheckoutViewArguments(key: key, ticketInfo: ticketInfo),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPaymentwebView({
    _i35.Key? key,
    required String checkoutURL,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.paymentwebView,
        arguments: PaymentwebViewArguments(key: key, checkoutURL: checkoutURL),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAnalyticsView({
    _i35.Key? key,
    required int organizationId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.analyticsView,
        arguments:
            AnalyticsViewArguments(key: key, organizationId: organizationId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTicketScanningView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.ticketScanningView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithManageEventsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.manageEventsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithManageTeamView({
    _i35.Key? key,
    required _i40.Organization organization,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.manageTeamView,
        arguments:
            ManageTeamViewArguments(key: key, organization: organization),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditEventView({
    _i35.Key? key,
    required _i39.Event event,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.editEventView,
        arguments: EditEventViewArguments(key: key, event: event),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
