import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'tickets_sheet_model.dart';

class TicketsSheet extends StackedView<TicketsSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;

  const TicketsSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  void onViewModelReady(TicketsSheetModel viewModel) {
    final ticketData = request.data['tickets'] ?? request.data['ticket'];
    viewModel.init(ticketData, completer);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    TicketsSheetModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: const BoxDecoration(
          color: Color(0xFF2A2A2A),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            _buildHeader(context, viewModel),
            _buildTicketsList(viewModel),
            if (viewModel.hasSelectedTickets) _buildSummary(viewModel),
            _buildCheckoutButton(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, TicketsSheetModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                viewModel.tickets.length > 1
                    ? 'Select Your Tickets'
                    : 'Select Your Ticket',
                style: const TextStyle(
                  color: kcWhiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (viewModel.tickets.length > 1)
                Text(
                  '${viewModel.tickets.length} ticket types available',
                  style: const TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                  ),
                ),
              // Show password protection status
              if (viewModel.allTicketsPasswordProtected)
                const Text(
                  'All tickets require passwords',
                  style: TextStyle(
                    color: kcPrimaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.close,
              color: kcWhiteColor,
              size: 24,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketsList(TicketsSheetModel viewModel) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: viewModel.tickets.length,
          itemBuilder: (context, index) {
            final ticket = viewModel.tickets[index];
            return _buildTicketOption(viewModel, ticket, index);
          },
        ),
      ),
    );
  }

  Widget _buildTicketOption(
      TicketsSheetModel viewModel, Map<String, dynamic> ticket, int index) {
    final ticketId = ticket['index']?.toString() ?? index.toString();
    final quantity = viewModel.getQuantity(ticketId);
    final isSelected = viewModel.isSelected(ticketId);
    final isAvailable = ticket['available'] ?? true;
    final requiresPassword = ticket['password_required'] ?? false;
    final isUnlocked = viewModel.isTicketUnlocked(ticketId);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected
            ? kcPrimaryColor.withOpacity(0.1)
            : requiresPassword && !isUnlocked
                ? const Color(0xFF333333).withOpacity(0.6) // Dimmed for locked
                : const Color(0xFF333333),
        borderRadius: BorderRadius.circular(12),
        border: isSelected
            ? Border.all(color: kcPrimaryColor, width: 1)
            : requiresPassword && !isUnlocked
                ? Border.all(color: kcPrimaryColor.withOpacity(0.3), width: 1)
                : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          ticket['name'] ?? 'Unnamed Ticket',
                          style: TextStyle(
                            color: requiresPassword && !isUnlocked
                                ? kcWhiteColor.withOpacity(0.6)
                                : kcWhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (requiresPassword) ...[
                          horizontalSpaceTiny,
                          Icon(
                            isUnlocked ? Icons.lock_open : Icons.lock,
                            size: 16,
                            color: isUnlocked ? Colors.green : kcPrimaryColor,
                          ),
                        ],
                      ],
                    ),
                    verticalSpaceTiny,
                    if (requiresPassword && !isUnlocked)
                      const Text(
                        'Password required',
                        style: TextStyle(
                          color: kcPrimaryColor,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    else
                      Text(
                        ticket['type'] == 'free' || ticket['price'] == 0
                            ? 'Free'
                            : 'KSH ${ticket['price']}',
                        style: TextStyle(
                          color:
                              ticket['type'] == 'free' || ticket['price'] == 0
                                  ? Colors.green
                                  : kcPrimaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    if (isUnlocked &&
                        ticket['description'] != null &&
                        ticket['description'].isNotEmpty) ...[
                      verticalSpaceTiny,
                      Text(
                        ticket['description'],
                        style: const TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 14,
                        ),
                      ),
                    ],
                    if (isUnlocked && ticket['limit'] != null) ...[
                      verticalSpaceTiny,
                      Text(
                        'Limit: ${ticket['limit']} per person',
                        style: const TextStyle(
                          color: Color(0xFF666666),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // if (!isAvailable)
              //   Container(
              //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              //     decoration: BoxDecoration(
              //       color: Colors.red.withOpacity(0.2),
              //       borderRadius: BorderRadius.circular(16),
              //       border: Border.all(color: Colors.red, width: 1),
              //     ),
              //     child: const Text(
              //       'Sold Out',
              //       style: TextStyle(
              //         color: Colors.red,
              //         fontSize: 12,
              //         fontWeight: FontWeight.w500,
              //       ),
              //     ),
              //   )
              // else
              if (requiresPassword && !isUnlocked)
                _buildUnlockButton(viewModel, ticketId)
              else if (isSelected)
                _buildQuantitySelector(viewModel, ticketId, quantity)
              else
                _buildSelectButton(viewModel, ticketId),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUnlockButton(TicketsSheetModel viewModel, String ticketId) {
    return ElevatedButton.icon(
      onPressed: () => viewModel.requestPasswordForTicket(ticketId),
      style: ElevatedButton.styleFrom(
        backgroundColor: kcPrimaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
      ),
      icon: const Icon(
        Icons.lock_open,
        color: kcWhiteColor,
        size: 16,
      ),
      label: const Text(
        'Unlock',
        style: TextStyle(
          color: kcWhiteColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildQuantitySelector(
      TicketsSheetModel viewModel, String ticketId, int quantity) {
    return Container(
      decoration: BoxDecoration(
        color: kcPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuantityButton(
            icon: Icons.remove,
            onPressed: () => viewModel.decreaseQuantity(ticketId),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              '$quantity',
              style: const TextStyle(
                color: kcWhiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _buildQuantityButton(
            icon: Icons.add,
            onPressed: () => viewModel.increaseQuantity(ticketId),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          color: kcWhiteColor,
          size: 16,
        ),
      ),
    );
  }

  Widget _buildSelectButton(TicketsSheetModel viewModel, String ticketId) {
    return ElevatedButton(
      onPressed: () => viewModel.selectTicket(ticketId),
      style: ElevatedButton.styleFrom(
        backgroundColor: kcPrimaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
      ),
      child: const Text(
        'Select',
        style: TextStyle(
          color: kcWhiteColor,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSummary(TicketsSheetModel viewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kcPrimaryColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              color: kcWhiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          verticalSpaceSmall,
          ...viewModel.getSelectedTicketsDetails().map(
                (ticket) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${ticket['name']} x${ticket['selected_quantity']}',
                          style: const TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Text(
                        'KSH ${ticket['subtotal']}',
                        style: const TextStyle(
                          color: kcWhiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          const Divider(color: Color(0xFF555555)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total (${viewModel.totalQuantity} tickets)',
                style: const TextStyle(
                  color: kcWhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'KSH ${viewModel.totalPrice}',
                style: const TextStyle(
                  color: kcPrimaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(TicketsSheetModel viewModel) {
    final hasPasswordProtectedTickets = viewModel.hasSelectedTickets &&
        viewModel
            .getSelectedTicketsDetails()
            .any((ticket) => ticket['password_required'] == true);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          if (hasPasswordProtectedTickets)
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: kcPrimaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: kcPrimaryColor.withOpacity(0.3)),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.lock_open,
                    size: 16,
                    color: Colors.green,
                  ),
                  horizontalSpaceTiny,
                  Expanded(
                    child: Text(
                      'Selected tickets have been unlocked and verified',
                      style: TextStyle(
                        color: kcWhiteColor,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          AppButton(
            onTap: () =>
                viewModel.hasSelectedTickets ? viewModel.checkout() : null,
            labelText: viewModel.hasSelectedTickets
                ? 'Checkout - KSH ${viewModel.totalPrice}'
                : 'Select Tickets',
          ),
        ],
      ),
    );
  }

  @override
  TicketsSheetModel viewModelBuilder(BuildContext context) {
    return TicketsSheetModel();
  }
}
