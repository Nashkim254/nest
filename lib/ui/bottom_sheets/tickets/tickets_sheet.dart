import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
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
    viewModel.init(request.data['ticket']);
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
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Color(0xFF2A2A2A),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            _buildHeader(context),
            _buildTicketsList(viewModel),
            _buildCheckoutButton(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Select Your Ticket',
            style: TextStyle(
              color: kcWhiteColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
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
        child: Column(
          children: [
            _buildTicketOption(viewModel, request.data['ticket']),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketOption(
      TicketsSheetModel viewModel, Map<String, dynamic> ticket) {
    final quantity = viewModel.getQuantity(ticket['index'].toString());
    final isSelected = viewModel.isSelected(ticket['index'].toString());

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket['name'],
                  style: const TextStyle(
                    color: kcWhiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  ticket['price'].toString(),
                  style: const TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          isSelected
              ? _buildQuantitySelector(
                  viewModel, ticket['index'].toString(), quantity)
              : _buildSelectButton(viewModel, ticket['index'].toString()),
        ],
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

  Widget _buildCheckoutButton(TicketsSheetModel viewModel) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: viewModel.hasSelectedTickets ? viewModel.checkout : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: kcPrimaryColor,
          disabledBackgroundColor: const Color(0xFF444444),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Checkout',
          style: TextStyle(
            color: kcWhiteColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  TicketsSheetModel viewModelBuilder(BuildContext context) {
    return TicketsSheetModel();
  }
}
