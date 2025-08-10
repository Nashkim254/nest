import 'package:flutter/material.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../models/ticket.dart';
import '../../common/app_strings.dart';

class UpcomingViewModel extends BaseViewModel {
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  //getters

  Animation<double> get pulseAnimation => _pulseAnimation;
  Animation<double> get scaleAnimation => _scaleAnimation;

  bool _isPressed = false;
  bool get isPressed => _isPressed;

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

  void initialize(TickerProvider vsync) {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: vsync,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: vsync,
    )..repeat();

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  void onPressDown() {
    _isPressed = true;
    _animationController.forward();
    notifyListeners();
  }

  void onPressUp() {
    _isPressed = false;
    _animationController.reverse();
    notifyListeners();
  }

  void onTap() {
    // Handle ticket tap - navigate to details
    print('Techno Pulse ticket tapped');
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pulseController.dispose();
    super.dispose();
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
}
