class TicketTier {
  final String name;
  final int count;
  final double percentage;

  TicketTier(this.name, this.count, this.percentage);
}

class TrafficSource {
  final String name;
  final int percentage;

  TrafficSource(this.name, this.percentage);
}

class PromoterData {
  final String name;
  final int tickets;

  PromoterData(this.name, this.tickets);
}

class ChartData {
  final String label;
  final double value;

  ChartData(this.label, this.value);
}

// UI-specific data models
class TicketTypeBreakdown {
  final String name;
  final int count;
  final double percentage;
  final String revenue;

  TicketTypeBreakdown(this.name, this.count, this.percentage, this.revenue);
}

class TopEventData {
  final String name;
  final int tickets;
  final String revenue;

  TopEventData(this.name, this.tickets, this.revenue);
}
