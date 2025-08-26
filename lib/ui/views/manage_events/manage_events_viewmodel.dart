import 'package:nest/models/events.dart';
import 'package:nest/ui/common/app_enums.dart';
import 'package:stacked/stacked.dart';

class ManageEventsViewModel extends BaseViewModel {
  List<Event> _events = [];
  EventFilter _selectedFilter = EventFilter.all;
  String _searchQuery = '';

  // Getters
  List<Event> get events => _events;
  EventFilter get selectedFilter => _selectedFilter;
  String get searchQuery => _searchQuery;

  List<Event> get filteredEvents {
    var filtered = _events.where((event) {
      // Search filter
      final matchesSearch = _searchQuery.isEmpty ||
          event.title.toLowerCase().contains(_searchQuery.toLowerCase());

      // Status filter
      bool matchesFilter;
      switch (_selectedFilter) {
        case EventFilter.all:
          matchesFilter = true;
          break;
        case EventFilter.upcoming:
          matchesFilter = DateTime.now().isBefore(event.startTime) &&
              event.status != EventStatus.past;
          break;
        case EventFilter.past:
          matchesFilter = DateTime.now().isAfter(event.startTime) ||
              event.status == EventStatus.past;
          break;
      }

      return matchesSearch && matchesFilter;
    }).toList();

    // Sort by date
    filtered.sort((a, b) => a.startTime.compareTo(b.startTime));
    return filtered;
  }

  // Actions
  void initialize() {
    _loadSampleData();
    notifyListeners();
  }

  void setFilter(EventFilter filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void createNewEvent() {
    // Navigate to create event screen
    // This would typically use navigation service
    print('Navigate to create new event');
  }

  void deleteEvent(int eventId) {
    _events.removeWhere((event) => event.id == eventId);
    notifyListeners();
  }

  void _loadSampleData() {
    _events = [];
  }
}
