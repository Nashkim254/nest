import 'package:flutter/material.dart';
import 'package:nest/models/events.dart';
import 'package:nest/ui/views/manage_events/widgets/status_chip.dart';
import 'package:nest/utils/utilities.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback? onMorePressed;

  const EventCard({
    Key? key,
    required this.event,
    this.onMorePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  event.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: onMorePressed,
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.grey,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            event.formattedDate,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              EventStatusChip(status: Utilities.getEventStatus(event.status)),
              const SizedBox(width: 12),
              Text(
                'Total Tickets: ${event.totalTickets}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
