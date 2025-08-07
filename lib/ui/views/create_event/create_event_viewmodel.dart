import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_enums.dart';
import 'package:stacked/stacked.dart';

import '../../../models/page_item.dart';

class CreateEventViewModel extends BaseViewModel {
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;
  bool _max1PerUser = false;
  bool get isMax1PerUser => _max1PerUser;
  set isMax1PerUser(bool value) {
    _max1PerUser = value;
    notifyListeners();
  }

  int _currentPage = 0;
  int get currentPage => _currentPage;
  EventMode _eventMode = EventMode.rsvp;
  EventMode get eventMode => _eventMode;
  set eventMode(EventMode mode) {
    _eventMode = mode;
    notifyListeners();
  }

  bool isPrivate = false;
  bool get isRsvP => _eventMode == EventMode.rsvp;
  bool get isPaid => _eventMode == EventMode.paid;

  togglePaidTickets() {
    _eventMode = _eventMode == EventMode.paid ? EventMode.rsvp : EventMode.paid;
    notifyListeners();
  }

  togglePrivate() {
    isPrivate = !isPrivate;
    notifyListeners();
  }

  final List<PageItem> _items = [
    PageItem(
      title: "Create Event",
    ),
    PageItem(
      title: "Ticket Setup",
    ),
    PageItem(
      title: "Event Visuals",
    ),
  ];
  List<PageItem> get items => _items;
  int get itemCount => _items.length;
  PageItem get currentItem => _items[_currentPage];
  bool get isFirstPage => _currentPage == 0;
  bool get isLastPage => _currentPage == _items.length - 1;
  double get progress => (_currentPage + 1) / _items.length;

  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  Future<void> nextPage() async {
    if (!isLastPage) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> previousPage() async {
    if (!isFirstPage) {
      await _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> goToPage(int index) async {
    await _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void onFinishPressed() {
    setBusy(true);

    // Simulate some async operation
    Future.delayed(const Duration(seconds: 1), () {
      setBusy(false);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
