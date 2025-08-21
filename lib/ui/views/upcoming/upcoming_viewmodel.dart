import 'package:logger/logger.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/models/events.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../models/organization_model.dart';
import '../../../models/ticket.dart';
import '../../../services/event_service.dart';
import '../../../services/user_service.dart';
import '../../common/app_strings.dart';

class UpcomingViewModel extends BaseViewModel {
  //getters
  final eventService = locator<EventService>();
  List<Event> upcomingEvents = [];
  final navigationService = locator<NavigationService>();
  bool _isPressed = false;
  bool get isPressed => _isPressed;
  Logger logger = Logger();
  DateTime get eventDate => DateTime(2024, 11, 15, 20, 0);

  Duration get timeUntilEvent => eventDate.difference(DateTime.now());

  String get countdownText {
    if (timeUntilEvent.isNegative) return 'Event Started';
    final days = timeUntilEvent.inDays;
    final hours = timeUntilEvent.inHours % 24;
    if (days > 0) return '${days}d ${hours}h left';
    return '${hours}h ${timeUntilEvent.inMinutes % 60}m left';
  }

  List<Ticket> getSampleTickets() {
    return [
      Ticket(
        id: '1',
        eventName: 'Neon Night Rave',
        eventDate: 'Fri, Oct 27',
        eventTime: '9:00 PM',
        ticketType: 'General Admission',
        imageUrl: scan,
        qrCode: 'QR_CODE_1',
        isSavedToWallet: false,
      ),
      Ticket(
        id: '2',
        eventName: 'City Lights Gala',
        eventDate: 'Sat, Nov 11',
        eventTime: '7:30 PM',
        ticketType: 'VIP Access',
        imageUrl: scan,
        isSavedToWallet: true,
        specialOffer: '20 x 20',
      ),
      Ticket(
        id: '3',
        eventName: 'Groove Fest 2023',
        eventDate: 'Sun, Dec 3',
        eventTime: '2:00 PM',
        ticketType: 'General Admission',
        imageUrl: scan,
        isSavedToWallet: false,
      ),
      // Add some past events for testing
      Ticket(
        id: '4',
        eventName: 'Summer Music Festival',
        eventDate: 'Sat, Aug 15',
        eventTime: '6:00 PM',
        ticketType: 'VIP Access',
        imageUrl: scan,
        isSavedToWallet: true,
      ),
    ];
  }

  void onPressDown() {
    _isPressed = true;
    notifyListeners();
  }

  void onPressUp() {
    _isPressed = false;
    notifyListeners();
  }

  void onTap() {
    // Handle ticket tap - navigate to details
    print('Techno Pulse ticket tapped');
  }

  findEvents() {
    final result = locator<BottomSheetService>().showCustomSheet(
      variant: BottomSheetType.finEvents,
      title: 'Find Events',
      isScrollControlled: true,
      barrierDismissible: true,
    );
    result.then((value) {
      if (value != null && value.confirmed) {
        // Handle confirmed action
        print('Find Events confirmed');
      } else {
        // Handle cancellation
        print('Find Events cancelled');
      }
    });
  }

  viewAllPeopleAndOrgs() {
    locator<NavigationService>().navigateToFindPeopleAndOrgsView();
  }

  viewAllEvents() {
    locator<NavigationService>().navigateToExploreEventsView();
  }

  viewEventDetails(Event event) {
    locator<NavigationService>().navigateToViewEventView(event: event);
  }

  int page = 1;
  int size = 10;
  Future getUpcomingEvents() async {
    setBusy(true);
    try {
      final response = await eventService.getMyEvents(page: page, size: size);
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i('Upcoming Events: ${response.data['events']}');

        final eventsList = response.data['events'];
        logger.i('Number of events: ${eventsList.length}');

        upcomingEvents = eventsList
            .map((event) {
              logger.i('Parsing event: $event');
              try {
                return Event.fromJson(event);
              } catch (e) {
                logger.e('Failed to parse event: $event');
                logger.e('Error: $e');
                return null;
              }
            })
            .whereType<Event>() // Only keep Event objects, filter out nulls
            .toList();
        logger.w('Upcoming Events: $upcomingEvents');

        return response.data;
      } else {
        logger.e('Failed to load upcoming events: ${response.message}');
        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to load upcoming events',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e, s) {
      logger.e('Error fetching upcoming events: $s');
      locator<SnackbarService>().showSnackbar(
        message: 'Error fetching upcoming events: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  List<Organization> myOrganizations = [];
  bool hasOrganizations = false;
  final userService = locator<UserService>();
  Future getMyOrganizations() async {
    setBusy(true);
    try {
      final response = await userService.getMyOrganization();
      if (response.statusCode == 200 && response.data != null) {
        hasOrganizations = true;
        Organization organization =
            Organization.fromJson(response.data['organization']);
        myOrganizations.add(organization);
        notifyListeners();
      } else if (response.statusCode == 404) {
        hasOrganizations = false;
        logger.w('No organizations found');
        notifyListeners();
      } else {
        // Handle error response
        logger.e('Failed to load organizations: ${response.message}');
        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to load organizations',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      // Handle exception
    } finally {
      setBusy(false);
    }
  }

  init() async {
    setBusy(true);
    try {
      await getUpcomingEvents();
      await getMyOrganizations();
    } catch (e) {
      logger.e('Error during initialization: $e');
      locator<SnackbarService>().showSnackbar(
        message: 'Error during initialization: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }
}
