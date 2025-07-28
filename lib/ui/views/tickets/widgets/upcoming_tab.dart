import 'package:flutter/material.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/ui/views/tickets/tickets_viewmodel.dart';
import 'package:nest/ui/views/tickets/widgets/ticket_widget.dart';

class UpcomingTicketsTab extends StatelessWidget {
  const UpcomingTicketsTab({super.key, required this.viewModel});
  final TicketsViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return TicketWidget(
            ticket: viewModel.getSampleTickets()[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) => verticalSpaceSmall,
        itemCount: viewModel.getSampleTickets().length,
      ),
    );
  }
}
