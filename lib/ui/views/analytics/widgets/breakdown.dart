// widgets/breakdowns_widget.dart
import 'package:flutter/material.dart';

import '../../../../models/analytics.dart';
import '../analytics_viewmodel.dart';

class BreakdownsWidget extends StatelessWidget {
  final AnalyticsViewModel viewModel;

  const BreakdownsWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Breakdowns',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildTicketTierBreakdown(viewModel.ticketTypeBreakdown),
        const SizedBox(height: 16),
        _buildTopEvents('Top Events by Tickets', viewModel.topEventsByTickets),
        const SizedBox(height: 16),
        _buildTopEvents('Top Events by Revenue', viewModel.topEventsByRevenue),
      ],
    );
  }

  Widget _buildTicketTierBreakdown(List<TicketTypeBreakdown> breakdown) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ticket Type Breakdown',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          if (breakdown.isEmpty)
            const Text(
              'No ticket data available',
              style: TextStyle(color: Colors.white54),
            )
          else
            ...breakdown.map((item) => _buildBreakdownItem(
                  item.name,
                  '${item.count} (${item.percentage.toStringAsFixed(1)}%)',
                  const Color(0xFFFF6B35),
                )),
        ],
      ),
    );
  }

  Widget _buildTopEvents(String title, List<TopEventData> events) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          if (events.isEmpty)
            const Text(
              'No events available',
              style: TextStyle(color: Colors.white54),
            )
          else
            ...events.map((event) => _buildBreakdownItem(
                  event.name,
                  '${event.tickets} tickets • ${event.revenue}',
                  const Color(0xFFFF6B35),
                )),
        ],
      ),
    );
  }

  Widget _buildBreakdownItem(String label, String value, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
