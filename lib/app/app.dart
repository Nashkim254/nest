import 'package:nest/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:nest/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:nest/ui/views/home/home_view.dart';
import 'package:nest/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:nest/ui/views/interest_selection/interest_selection_view.dart';
import 'package:nest/ui/views/location/location_view.dart';
import 'package:nest/ui/views/login/login_view.dart';
import 'package:nest/ui/views/register/register_view.dart';
import 'package:nest/ui/views/discover/discover_view.dart';
import 'package:nest/ui/views/hosting/hosting_view.dart';
import 'package:nest/ui/views/messages/messages_view.dart';
import 'package:nest/ui/views/tickets/tickets_view.dart';
import 'package:nest/ui/views/profile/profile_view.dart';
import 'package:nest/ui/views/navigation/navigation_view.dart';
import 'package:nest/services/global_service.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: InterestSelectionView),
    MaterialRoute(page: LocationView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: DiscoverView),
    MaterialRoute(page: HostingView),
    MaterialRoute(page: MessagesView),
    MaterialRoute(page: TicketsView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: NavigationView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: GlobalService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
