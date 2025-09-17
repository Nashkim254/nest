import 'package:flutter/material.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/ui/views/tickets/tickets_viewmodel.dart';
import 'package:nest/ui/views/tickets/widgets/ticket_widget.dart';
import 'package:nest/ui/views/tickets/widgets/empty_tickets_widget.dart';

class UpcomingTicketsTab extends StatelessWidget {
  const UpcomingTicketsTab({super.key, required this.viewModel});
  final TicketsViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    if (viewModel.tickets.isEmpty) {
      return const EmptyTicketsWidget(
        title: 'No Upcoming Events',
        subtitle: 'You don\'t have any upcoming events.\nStart exploring and book your next experience!',
        icon: Icons.event_available_outlined,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return TicketWidget(
            ticket: viewModel.tickets[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            verticalSpaceSmall,
        itemCount: viewModel.tickets.length,
      ),
    );
  }
}
