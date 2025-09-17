import 'package:flutter/material.dart';
import 'package:nest/ui/views/tickets/widgets/ticket_widget.dart';
import 'package:nest/ui/views/tickets/widgets/empty_tickets_widget.dart';

import '../../../common/ui_helpers.dart';
import '../tickets_viewmodel.dart';

class PastTicketsTab extends StatelessWidget {
  const PastTicketsTab({super.key, required this.viewModel});
  final TicketsViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    if (viewModel.tickets.isEmpty) {
      return const EmptyTicketsWidget(
        title: 'No Event History',
        subtitle: 'You haven\'t attended any events yet.\nStart exploring and create some memories!',
        icon: Icons.history_outlined,
      );
    }

    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: TicketWidget(
            ticket: viewModel.tickets[index],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => verticalSpaceSmall,
      itemCount: viewModel.tickets.length,
    );
  }
}
