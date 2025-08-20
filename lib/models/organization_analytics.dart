class OrganizationAnalytics {
  final int organizationId;
  final TimeRange timeRange;
  final EventAnalytics eventAnalytics;
  final TicketAnalytics ticketAnalytics;
  final RevenueAnalytics revenueAnalytics;
  final GuestListAnalytics guestListAnalytics;
  final TopEvents topEvents;
  final dynamic ticketTypeDistribution;
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
      ticketTypeDistribution: json['ticket_type_distribution'],
      monthlyTrends: (json['monthly_trends'] as List)
          .map((e) => MonthlyTrend.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "organization_id": organizationId,
        "time_range": timeRange.toJson(),
        "event_analytics": eventAnalytics.toJson(),
        "ticket_analytics": ticketAnalytics.toJson(),
        "revenue_analytics": revenueAnalytics.toJson(),
        "guest_list_analytics": guestListAnalytics.toJson(),
        "top_events": topEvents.toJson(),
        "ticket_type_distribution": ticketTypeDistribution,
        "monthly_trends": monthlyTrends.map((e) => e.toJson()).toList(),
      };
}

class TimeRange {
  final String startDate;
  final String endDate;
  final int days;

  TimeRange({
    required this.startDate,
    required this.endDate,
    required this.days,
  });

  factory TimeRange.fromJson(Map<String, dynamic> json) => TimeRange(
        startDate: json['start_date'],
        endDate: json['end_date'],
        days: json['days'],
      );

  Map<String, dynamic> toJson() => {
        "start_date": startDate,
        "end_date": endDate,
        "days": days,
      };
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

  factory EventAnalytics.fromJson(Map<String, dynamic> json) => EventAnalytics(
        totalEvents: json['total_events'],
        activeEvents: json['active_events'],
        recentEvents: json['recent_events'],
      );

  Map<String, dynamic> toJson() => {
        "total_events": totalEvents,
        "active_events": activeEvents,
        "recent_events": recentEvents,
      };
}

class TicketAnalytics {
  final int totalTickets;
  final int validatedTickets;
  final int recentTickets;
  final int validationRate;

  TicketAnalytics({
    required this.totalTickets,
    required this.validatedTickets,
    required this.recentTickets,
    required this.validationRate,
  });

  factory TicketAnalytics.fromJson(Map<String, dynamic> json) =>
      TicketAnalytics(
        totalTickets: json['total_tickets'],
        validatedTickets: json['validated_tickets'],
        recentTickets: json['recent_tickets'],
        validationRate: json['validation_rate'],
      );

  Map<String, dynamic> toJson() => {
        "total_tickets": totalTickets,
        "validated_tickets": validatedTickets,
        "recent_tickets": recentTickets,
        "validation_rate": validationRate,
      };
}

class RevenueAnalytics {
  final int totalRevenue;
  final int recentRevenue;
  final int averagePerTicket;

  RevenueAnalytics({
    required this.totalRevenue,
    required this.recentRevenue,
    required this.averagePerTicket,
  });

  factory RevenueAnalytics.fromJson(Map<String, dynamic> json) =>
      RevenueAnalytics(
        totalRevenue: json['total_revenue'],
        recentRevenue: json['recent_revenue'],
        averagePerTicket: json['average_per_ticket'],
      );

  Map<String, dynamic> toJson() => {
        "total_revenue": totalRevenue,
        "recent_revenue": recentRevenue,
        "average_per_ticket": averagePerTicket,
      };
}

class GuestListAnalytics {
  final int totalEntries;
  final int approvedEntries;
  final int approvalRate;

  GuestListAnalytics({
    required this.totalEntries,
    required this.approvedEntries,
    required this.approvalRate,
  });

  factory GuestListAnalytics.fromJson(Map<String, dynamic> json) =>
      GuestListAnalytics(
        totalEntries: json['total_entries'],
        approvedEntries: json['approved_entries'],
        approvalRate: json['approval_rate'],
      );

  Map<String, dynamic> toJson() => {
        "total_entries": totalEntries,
        "approved_entries": approvedEntries,
        "approval_rate": approvalRate,
      };
}

class TopEvents {
  final dynamic byTickets;
  final dynamic byRevenue;

  TopEvents({
    this.byTickets,
    this.byRevenue,
  });

  factory TopEvents.fromJson(Map<String, dynamic> json) => TopEvents(
        byTickets: json['by_tickets'],
        byRevenue: json['by_revenue'],
      );

  Map<String, dynamic> toJson() => {
        "by_tickets": byTickets,
        "by_revenue": byRevenue,
      };
}

class MonthlyTrend {
  final String month;
  final int eventCount;
  final int ticketCount;
  final int revenue;

  MonthlyTrend({
    required this.month,
    required this.eventCount,
    required this.ticketCount,
    required this.revenue,
  });

  factory MonthlyTrend.fromJson(Map<String, dynamic> json) => MonthlyTrend(
        month: json['month'],
        eventCount: json['event_count'],
        ticketCount: json['ticket_count'],
        revenue: json['revenue'],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "event_count": eventCount,
        "ticket_count": ticketCount,
        "revenue": revenue,
      };
}
