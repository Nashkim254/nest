// models/analytics_models.dart
class OrganizationAnalytics {
  final int organizationId;
  final TimeRange timeRange;
  final EventAnalytics eventAnalytics;
  final TicketAnalytics ticketAnalytics;
  final RevenueAnalytics revenueAnalytics;
  final GuestListAnalytics guestListAnalytics;
  final TopEvents topEvents;
  final List<TicketTypeDistribution> ticketTypeDistribution;
  final List<MonthlyTrend> monthlyTrends;

  OrganizationAnalytics({
    required this.organizationId,
    required this.timeRange,
    required this.eventAnalytics,
    required this.ticketAnalytics,
    required this.revenueAnalytics,
    required this.guestListAnalytics,
    required this.topEvents,
    required this.ticketTypeDistribution,
    required this.monthlyTrends,
  });

  factory OrganizationAnalytics.fromJson(Map<String, dynamic> json) {
    return OrganizationAnalytics(
      organizationId: json['organization_id'],
      timeRange: TimeRange.fromJson(json['time_range']),
      eventAnalytics: EventAnalytics.fromJson(json['event_analytics']),
      ticketAnalytics: TicketAnalytics.fromJson(json['ticket_analytics']),
      revenueAnalytics: RevenueAnalytics.fromJson(json['revenue_analytics']),
      guestListAnalytics:
          GuestListAnalytics.fromJson(json['guest_list_analytics']),
      topEvents: TopEvents.fromJson(json['top_events']),
      ticketTypeDistribution: (json['ticket_type_distribution'] as List)
          .map((x) => TicketTypeDistribution.fromJson(x))
          .toList(),
      monthlyTrends: (json['monthly_trends'] as List)
          .map((x) => MonthlyTrend.fromJson(x))
          .toList(),
    );
  }
}

class TimeRange {
  final DateTime startDate;
  final DateTime endDate;
  final int days;

  TimeRange({
    required this.startDate,
    required this.endDate,
    required this.days,
  });

  factory TimeRange.fromJson(Map<String, dynamic> json) {
    return TimeRange(
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      days: json['days'],
    );
  }

  String get displayRange {
    if (days <= 7) return 'Last 7 Days';
    if (days <= 30) return 'Last 30 Days';
    if (days <= 90) return 'Last 3 Months';
    return 'Custom Range';
  }
}

class EventAnalytics {
  final int totalEvents;
  final int activeEvents;
  final int recentEvents;

  EventAnalytics({
    required this.totalEvents,
    required this.activeEvents,
    required this.recentEvents,
  });

  factory EventAnalytics.fromJson(Map<String, dynamic> json) {
    return EventAnalytics(
      totalEvents: json['total_events'],
      activeEvents: json['active_events'],
      recentEvents: json['recent_events'],
    );
  }
}

class TicketAnalytics {
  final int totalTickets;
  final int validatedTickets;
  final int recentTickets;
  final double validationRate;

  TicketAnalytics({
    required this.totalTickets,
    required this.validatedTickets,
    required this.recentTickets,
    required this.validationRate,
  });

  factory TicketAnalytics.fromJson(Map<String, dynamic> json) {
    return TicketAnalytics(
      totalTickets: json['total_tickets'],
      validatedTickets: json['validated_tickets'],
      recentTickets: json['recent_tickets'],
      validationRate: (json['validation_rate'] as num).toDouble(),
    );
  }

  String get validationRatePercentage =>
      '${(validationRate * 100).toStringAsFixed(1)}%';
}

class RevenueAnalytics {
  final double totalRevenue;
  final double recentRevenue;
  final double averagePerTicket;

  RevenueAnalytics({
    required this.totalRevenue,
    required this.recentRevenue,
    required this.averagePerTicket,
  });

  factory RevenueAnalytics.fromJson(Map<String, dynamic> json) {
    return RevenueAnalytics(
      totalRevenue: (json['total_revenue'] as num).toDouble(),
      recentRevenue: (json['recent_revenue'] as num).toDouble(),
      averagePerTicket: (json['average_per_ticket'] as num).toDouble(),
    );
  }

  String get formattedTotalRevenue => 'KES ${totalRevenue.toStringAsFixed(0)}';
  String get formattedRecentRevenue =>
      'KES ${recentRevenue.toStringAsFixed(0)}';
  String get formattedAveragePerTicket =>
      'KES ${averagePerTicket.toStringAsFixed(0)}';
}

class GuestListAnalytics {
  final int totalEntries;
  final int approvedEntries;
  final double approvalRate;

  GuestListAnalytics({
    required this.totalEntries,
    required this.approvedEntries,
    required this.approvalRate,
  });

  factory GuestListAnalytics.fromJson(Map<String, dynamic> json) {
    return GuestListAnalytics(
      totalEntries: json['total_entries'],
      approvedEntries: json['approved_entries'],
      approvalRate: (json['approval_rate'] as num).toDouble(),
    );
  }

  String get approvalRatePercentage =>
      '${(approvalRate * 100).toStringAsFixed(1)}%';
}

class TopEvents {
  final List<TopEvent> byTickets;
  final List<TopEvent> byRevenue;

  TopEvents({
    required this.byTickets,
    required this.byRevenue,
  });

  factory TopEvents.fromJson(Map<String, dynamic> json) {
    return TopEvents(
      byTickets: (json['by_tickets'] as List)
          .map((x) => TopEvent.fromJson(x))
          .toList(),
      byRevenue: (json['by_revenue'] as List)
          .map((x) => TopEvent.fromJson(x))
          .toList(),
    );
  }
}

class TopEvent {
  final int eventId;
  final String eventTitle;
  final int ticketCount;
  final double revenue;

  TopEvent({
    required this.eventId,
    required this.eventTitle,
    required this.ticketCount,
    required this.revenue,
  });

  factory TopEvent.fromJson(Map<String, dynamic> json) {
    return TopEvent(
      eventId: json['event_id'],
      eventTitle: json['event_title'],
      ticketCount: json['ticket_count'],
      revenue: (json['revenue'] as num).toDouble(),
    );
  }

  String get formattedRevenue => 'KES ${revenue.toStringAsFixed(0)}';
}

class TicketTypeDistribution {
  final String ticketType;
  final int count;
  final double revenue;

  TicketTypeDistribution({
    required this.ticketType,
    required this.count,
    required this.revenue,
  });

  factory TicketTypeDistribution.fromJson(Map<String, dynamic> json) {
    return TicketTypeDistribution(
      ticketType: json['ticket_type'],
      count: json['count'],
      revenue: (json['revenue'] as num).toDouble(),
    );
  }

  String get formattedRevenue => 'KES ${revenue.toStringAsFixed(0)}';
  String get capitalizedType => ticketType.toUpperCase();
}

class MonthlyTrend {
  final String month;
  final int eventCount;
  final int ticketCount;
  final double revenue;

  MonthlyTrend({
    required this.month,
    required this.eventCount,
    required this.ticketCount,
    required this.revenue,
  });

  factory MonthlyTrend.fromJson(Map<String, dynamic> json) {
    return MonthlyTrend(
      month: json['month'],
      eventCount: json['event_count'],
      ticketCount: json['ticket_count'],
      revenue: (json['revenue'] as num).toDouble(),
    );
  }

  DateTime get monthDate => DateTime.parse('$month-01');

  String get formattedMonth {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[monthDate.month - 1];
  }

  String get formattedRevenue => 'KES ${revenue.toStringAsFixed(0)}';
}

// Chart data models for UI
class ChartDataPoint {
  final String label;
  final double value;
  final DateTime? date;

  ChartDataPoint(this.label, this.value, {this.date});
}

// Extensions for easier data transformation
extension MonthlyTrendCharts on List<MonthlyTrend> {
  List<ChartDataPoint> get revenueChart =>
      map((trend) => ChartDataPoint(trend.formattedMonth, trend.revenue,
          date: trend.monthDate)).toList();

  List<ChartDataPoint> get ticketChart => map((trend) => ChartDataPoint(
      trend.formattedMonth, trend.ticketCount.toDouble(),
      date: trend.monthDate)).toList();

  List<ChartDataPoint> get eventChart => map((trend) => ChartDataPoint(
      trend.formattedMonth, trend.eventCount.toDouble(),
      date: trend.monthDate)).toList();
}
