import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/analytics.dart';
import '../../../models/organization_analytics.dart';
import '../../../services/user_service.dart';

class AnalyticsViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final userService = locator<UserService>();
  // Data state
  OrganizationAnalytics? _analyticsData;
  String? _errorMessage;

  // Filter states
  String _selectedEvent = 'All Events';
  String _selectedDateRange = 'Last 30 Days';
  bool _filterExpanded = false;

  // Getters
  OrganizationAnalytics? get analyticsData => _analyticsData;
  String? get errorMessage => _errorMessage;
  String get selectedEvent => _selectedEvent;
  String get selectedDateRange => _selectedDateRange;
  bool get filterExpanded => _filterExpanded;
  bool get hasData => _analyticsData != null;

  // Overview data from backend
  int get totalEvents => _analyticsData?.eventAnalytics.totalEvents ?? 0;
  int get activeEvents => _analyticsData?.eventAnalytics.activeEvents ?? 0;
  int get recentEvents => _analyticsData?.eventAnalytics.recentEvents ?? 0;

  int get totalTickets => _analyticsData?.ticketAnalytics.totalTickets ?? 0;
  int get validatedTickets =>
      _analyticsData?.ticketAnalytics.validatedTickets ?? 0;
  String get validationRate =>
      _analyticsData?.ticketAnalytics.validationRatePercentage ?? '0%';

  String get totalRevenue =>
      _analyticsData?.revenueAnalytics.formattedTotalRevenue ?? 'KES 0';
  String get recentRevenue =>
      _analyticsData?.revenueAnalytics.formattedRecentRevenue ?? 'KES 0';
  String get averagePerTicket =>
      _analyticsData?.revenueAnalytics.formattedAveragePerTicket ?? 'KES 0';

  int get totalGuestEntries =>
      _analyticsData?.guestListAnalytics.totalEntries ?? 0;
  int get approvedEntries =>
      _analyticsData?.guestListAnalytics.approvedEntries ?? 0;
  String get approvalRate =>
      _analyticsData?.guestListAnalytics.approvalRatePercentage ?? '0%';

  // Chart data from backend
  List<ChartDataPoint> get revenueChartData =>
      _analyticsData?.monthlyTrends.revenueChart ?? [];

  List<ChartDataPoint> get ticketSalesChartData =>
      _analyticsData?.monthlyTrends.ticketChart ?? [];

  List<ChartDataPoint> get eventChartData =>
      _analyticsData?.monthlyTrends.eventChart ?? [];

  // Breakdown data
  List<TicketTypeBreakdown> get ticketTypeBreakdown {
    if (_analyticsData?.ticketTypeDistribution == null) return [];

    final total = _analyticsData!.ticketTypeDistribution
        .fold<int>(0, (sum, item) => sum + item.count);

    return _analyticsData!.ticketTypeDistribution.map((item) {
      final percentage = total > 0 ? (item.count / total) * 100 : 0.0;
      return TicketTypeBreakdown(
        item.capitalizedType,
        item.count,
        percentage,
        item.formattedRevenue,
      );
    }).toList();
  }

  List<TopEventData> get topEventsByTickets =>
      _analyticsData?.topEvents.byTickets
          .map((event) => TopEventData(
              event.eventTitle, event.ticketCount, event.formattedRevenue))
          .toList() ??
      [];

  List<TopEventData> get topEventsByRevenue =>
      _analyticsData?.topEvents.byRevenue
          .map((event) => TopEventData(
              event.eventTitle, event.ticketCount, event.formattedRevenue))
          .toList() ??
      [];

  // Time range display
  String get currentTimeRange =>
      _analyticsData?.timeRange.displayRange ?? 'Last 30 Days';

  // Initialize and fetch data
  Future<void> initialize(int id) async {
    await fetchAnalytics(id);
  }

  Future<void> fetchAnalytics(int organizationId) async {
    setBusy(true);
    _errorMessage = null;

    try {
      _analyticsData = await getOrganizationAnalytics(organizationId);

      if (_analyticsData != null) {
        _selectedDateRange = _analyticsData!.timeRange.displayRange;
      }

      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load analytics: ${e.toString()}';
      notifyListeners();
    } finally {
      setBusy(false);
    }
  }

  // Filter actions
  void toggleFilter() {
    _filterExpanded = !_filterExpanded;
    notifyListeners();
  }

  Future<void> showEventFilter(int id) async {
    // You can implement a dialog to select specific events
    // For now, we'll just refresh with all events
    await fetchAnalytics(id);
  }

  Future<void> showDateFilter(int id) async {
    // You can implement a date range picker
    // For now, we'll cycle through common ranges
    int newRange;
    switch (_selectedDateRange) {
      case 'Last 7 Days':
        newRange = 30;
        break;
      case 'Last 30 Days':
        newRange = 90;
        break;
      case 'Last 3 Months':
        newRange = 365;
        break;
      default:
        newRange = 7;
    }

    await fetchAnalytics(id);
  }

  Future<void> updateEventFilter(String event, int id) async {
    _selectedEvent = event;
    notifyListeners();
    await fetchAnalytics(id);
  }

  Future<void> updateDateFilter(int days, int id) async {
    await fetchAnalytics(id);
  }

  Future<void> refreshData(int id) async {
    await fetchAnalytics(id);
  }

  // Helper methods for UI
  bool get hasTicketData => totalTickets > 0;
  bool get hasRevenueData =>
      _analyticsData?.revenueAnalytics.totalRevenue != null &&
      _analyticsData!.revenueAnalytics.totalRevenue > 0;
  bool get hasEventData => totalEvents > 0;
  bool get hasChartData => _analyticsData?.monthlyTrends.isNotEmpty == true;

  // Performance indicators
  String get ticketTrend {
    if (_analyticsData?.monthlyTrends == null ||
        _analyticsData!.monthlyTrends.length < 2) {
      return 'No trend data';
    }

    final recent = _analyticsData!.monthlyTrends.last.ticketCount;
    final previous = _analyticsData!
        .monthlyTrends[_analyticsData!.monthlyTrends.length - 2].ticketCount;

    if (recent > previous) return '↗ Trending up';
    if (recent < previous) return '↘ Trending down';
    return '→ Steady';
  }

  String get revenueTrend {
    if (_analyticsData?.monthlyTrends == null ||
        _analyticsData!.monthlyTrends.length < 2) {
      return 'No trend data';
    }

    final recent = _analyticsData!.monthlyTrends.last.revenue;
    final previous = _analyticsData!
        .monthlyTrends[_analyticsData!.monthlyTrends.length - 2].revenue;

    if (recent > previous) return '↗ Trending up';
    if (recent < previous) return '↘ Trending down';
    return '→ Steady';
  }

  @override
  void dispose() {
    super.dispose();
  }

  Logger logger = Logger();
  Future<OrganizationAnalytics?> getOrganizationAnalytics(
      int organizationId) async {
    setBusy(true);
    try {
      final response =
          await userService.getMyOrganizationAnalytics(organizationId);
      if (response.statusCode == 200 && response.data != null) {
        _analyticsData = OrganizationAnalytics.fromJson(response.data);
        notifyListeners();
        debugPrint('My Organizations Analytics: ${response.data}',
            wrapWidth: 1024);
      } else if (response.statusCode == 404) {
        logger.w('No organizations Analytics found');
        notifyListeners();
      } else {
        logger.e('Failed to load organization Analytics: ${response.message}');
        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to load organizations Analytics',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      // Handle exception
    } finally {
      setBusy(false);
    }
    return _analyticsData;
  }
}
