import 'package:flutter/material.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class FinEventsSheetModel extends BaseViewModel {
  Function(SheetResponse)? _completer;
  final searchController = TextEditingController();
  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  set searchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void onSearchChanged(String value) {
    searchQuery = value;
  }

  void initialize(Function(SheetResponse) completer) {
    _completer = completer;
  }

  void submitReport() {
    // Close sheet with selected reason
    _completer!(
      SheetResponse(
        confirmed: true,
        data: {},
      ),
    );
  }

  void closeSheet() {
    _completer?.call(SheetResponse(confirmed: false));
  }

  String _selectedDateFilter = 'This Week';
  String _selectedLocationFilter = 'Near Me';

  final List<String> _dateFilters = [
    'Today',
    'Tomorrow',
    'This Week',
    'This Month'
  ];
  final List<String> _locationFilters = ['Near Me', 'Select City'];

  // Getters
  String get selectedDateFilter => _selectedDateFilter;
  String get selectedLocationFilter => _selectedLocationFilter;
  List<String> get dateFilters => _dateFilters;
  List<String> get locationFilters => _locationFilters;

  // Actions
  void setSelectedDateFilter(String filter) {
    _selectedDateFilter = filter;
    notifyListeners();

    // Optional: Add analytics or other side effects
    _logFilterSelection('date', filter);
  }

  void setSelectedLocationFilter(String filter) {
    _selectedLocationFilter = filter;
    notifyListeners();

    // Optional: Add analytics or other side effects
    _logFilterSelection('location', filter);
  }

  // Reset filters to default
  void resetFilters() {
    _selectedDateFilter = 'This Week';
    _selectedLocationFilter = 'Near Me';
    notifyListeners();
  }

  // Get current filter state as Map (useful for API calls)
  Map<String, String> getCurrentFilters() {
    return {
      'date': _selectedDateFilter,
      'location': _selectedLocationFilter,
    };
  }

  // Private helper method for logging
  void _logFilterSelection(String filterType, String filterValue) {
    // Add your analytics/logging logic here
    print('Filter selected - Type: $filterType, Value: $filterValue');
  }

  // Method to apply filters (call API, update data, etc.)
  Future<void> applyFilters() async {
    setBusy(true);

    try {
      // Add your filter application logic here
      // e.g., call API with current filters
      final filters = getCurrentFilters();

      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      locator<NavigationService>().navigateToExploreEventsView();
      print('Filters applied: $filters');
    } catch (e) {
      // Handle errors
      print('Error applying filters: $e');
    } finally {
      setBusy(false);
    }
  }

  clearFilters() {
    _selectedDateFilter = 'This Week';
    _selectedLocationFilter = 'Near Me';
    searchQuery = '';
    notifyListeners();
  }
}
