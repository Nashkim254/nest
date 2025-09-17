import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import '../../../models/confirmation_method.dart';
import '../../../models/payment_method.dart';
import '../../../models/ticket_item.dart';
import '../../common/app_enums.dart';
import 'checkout_viewmodel.dart';

class CheckoutView extends StackedView<CheckoutViewModel> {
  const CheckoutView({Key? key, required this.ticketInfo}) : super(key: key);
  final Map<dynamic, dynamic> ticketInfo;

  @override
  void onViewModelReady(CheckoutViewModel viewModel) {
    viewModel.init(ticketInfo);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    CheckoutViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        appBar: AppBar(
          backgroundColor: kcDarkColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kcWhiteColor,
            ),
            onPressed: viewModel.goBack,
          ),
          title: const Text(
            'Checkout',
            style: TextStyle(
              color: kcWhiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              spacedDivider,
              // Tickets Section (updated for multiple tickets)
              _buildTicketsSection(viewModel),
              const SizedBox(height: 32),

              // Password Requirements Notice
              if (viewModel.requiresPassword || viewModel.isMixedProtection)
                _buildPasswordNotice(viewModel),

              // Agreement Checkboxes
              _buildAgreementSection(viewModel),
              const SizedBox(height: 32),

              // Order Summary
              _buildOrderSummary(viewModel),
              const SizedBox(height: 32),

              // Payment Method
              _buildPaymentMethodSection(viewModel),
              const SizedBox(height: 32),

              // Confirmation Method
              _buildConfirmationSection(viewModel),
              const SizedBox(height: 40),

              // Confirm Button
              _buildConfirmButton(viewModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketsSection(CheckoutViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          viewModel.isMultipleTickets ? 'Your Tickets' : 'Your Ticket',
          style: const TextStyle(
            color: kcWhiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ...viewModel.tickets.asMap().entries.map((entry) {
          final index = entry.key;
          final ticket = entry.value;
          return _buildTicketCard(viewModel, ticket, index);
        }),
      ],
    );
  }

  Widget _buildTicketCard(
      CheckoutViewModel viewModel, TicketItem ticket, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kcDarkGreyColor,
        borderRadius: BorderRadius.circular(12),
        border: ticket.passwordRequired
            ? Border.all(color: kcPrimaryColor.withOpacity(0.5), width: 1)
            : null,
      ),
      child: Column(
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
                          ticket.name,
                          style: const TextStyle(
                            color: kcWhiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (ticket.passwordRequired) ...[
                          horizontalSpaceTiny,
                          const Icon(
                            Icons.lock,
                            size: 14,
                            color: kcPrimaryColor,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      ticket.formattedPrice,
                      style: TextStyle(
                        color: ticket.isFree ? Colors.green : Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (viewModel.isMultipleTickets)
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => viewModel.decrementTicketQuantity(index),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3A3A3A),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: kcWhiteColor,
                          size: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '${ticket.quantity}',
                        style: const TextStyle(
                          color: kcWhiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => viewModel.incrementTicketQuantity(index),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3A3A3A),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: kcWhiteColor,
                          size: 16,
                        ),
                      ),
                    ),
                    if (viewModel.tickets.length > 1) ...[
                      horizontalSpaceSmall,
                      GestureDetector(
                        onTap: () => viewModel.removeTicket(index),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.red, width: 1),
                          ),
                          child: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ],
                )
              else
                // Legacy single ticket quantity controls
                Row(
                  children: [
                    GestureDetector(
                      onTap: viewModel.decrementQuantity,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3A3A3A),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: kcWhiteColor,
                          size: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '${ticket.quantity}',
                        style: const TextStyle(
                          color: kcWhiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: viewModel.incrementQuantity,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3A3A3A),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: kcWhiteColor,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          if (viewModel.isMultipleTickets) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subtotal',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Text(
                  ticket.formattedTotal,
                  style: const TextStyle(
                    color: kcWhiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPasswordNotice(CheckoutViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kcPrimaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: kcPrimaryColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.lock,
            size: 20,
            color: kcPrimaryColor,
          ),
          horizontalSpaceSmall,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Password Verification Required',
                  style: TextStyle(
                    color: kcWhiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  viewModel.isMixedProtection
                      ? 'Some of your selected tickets require password verification'
                      : 'All selected tickets require password verification',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgreementSection(CheckoutViewModel viewModel) {
    return Column(
      children: [
        _buildCheckboxRow(
          'Agree with Nest TOS',
          viewModel.agreeWithNestTOS,
          viewModel.toggleNestTOS,
        ),
        const SizedBox(height: 16),
        _buildCheckboxRow(
          'Agree with Org TOS',
          viewModel.agreeWithOrgTOS,
          viewModel.toggleOrgTOS,
        ),
      ],
    );
  }

  Widget _buildCheckboxRow(
      String title, bool value, Function(bool?) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: kcWhiteColor,
            fontSize: 16,
          ),
        ),
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: kcPrimaryColor,
          checkColor: kcWhiteColor,
          side: const BorderSide(color: Colors.grey, width: 1),
        ),
      ],
    );
  }

  Widget _buildOrderSummary(CheckoutViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(
            color: kcWhiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),

        // Show individual ticket breakdown for multiple tickets
        if (viewModel.isMultipleTickets) ...[
          ...viewModel.tickets.map((ticket) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${ticket.name} x${ticket.quantity}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      ticket.formattedTotal,
                      style: const TextStyle(
                        color: kcWhiteColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 8),
          Container(
            height: 1,
            color: const Color(0xFF3A3A3A),
          ),
          const SizedBox(height: 8),
        ],

        _buildSummaryRow(
            'Subtotal', 'USD ${viewModel.subtotal.toStringAsFixed(0)}'),
        const SizedBox(height: 8),
        _buildSummaryRow(
            'Service Fee', 'USD ${viewModel.serviceFee.toStringAsFixed(0)}'),
        const SizedBox(height: 16),
        Container(
          height: 1,
          color: const Color(0xFF3A3A3A),
        ),
        const SizedBox(height: 16),
        _buildSummaryRow(
          'Total',
          'USD ${viewModel.total.toStringAsFixed(0)}',
          isTotal: true,
        ),
        if (viewModel.isMultipleTickets) ...[
          const SizedBox(height: 8),
          Text(
            '${viewModel.totalQuantity} tickets total',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isTotal ? kcPrimaryColor : Colors.grey,
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            color: isTotal ? kcPrimaryColor : kcWhiteColor,
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSection(CheckoutViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(
            color: kcWhiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ...viewModel.paymentMethods.map(
          (method) => _buildPaymentMethodTile(method, viewModel),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodTile(
    PaymentMethod method,
    CheckoutViewModel viewModel,
  ) {
    final isSelected = viewModel.selectedPaymentMethod == method;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => viewModel.selectPaymentMethod(method),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: kcDarkGreyColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? kcPrimaryColor : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: _getPaymentMethodColor(method.type),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: SvgPicture.asset(
                  _getPaymentMethodIcon(method.type),
                  color: kcPrimaryColor,
                  height: 16,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                method.displayName,
                style: const TextStyle(
                  color: kcWhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmationSection(CheckoutViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Get Confirmation Via',
          style: TextStyle(
            color: kcWhiteColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ...viewModel.confirmationMethods.map(
          (method) => _buildConfirmationMethodTile(method, viewModel),
        ),
      ],
    );
  }

  Widget _buildConfirmationMethodTile(
    ConfirmationMethod method,
    CheckoutViewModel viewModel,
  ) {
    final isSelected = viewModel.selectedConfirmationMethod == method;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => viewModel.selectConfirmationMethod(method),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? kcPrimaryColor : Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: kcPrimaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(
                  method.type == ConfirmationMethodType.sms
                      ? Icons.sms_outlined
                      : Icons.email_outlined,
                  color: kcWhiteColor,
                  size: 16,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                method.displayName,
                style: const TextStyle(
                  color: kcWhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmButton(CheckoutViewModel viewModel) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: viewModel.canProceedToPayment
            ? viewModel.confirmAndGetTicket
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: kcPrimaryColor,
          disabledBackgroundColor: const Color(0xFF3A3A3A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: viewModel.isBusy
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: kcWhiteColor,
                  strokeWidth: 2,
                ),
              )
            : Text(
                viewModel.isMultipleTickets
                    ? 'Confirm & Get Tickets - USD ${viewModel.total.toStringAsFixed(0)}'
                    : 'Confirm & Get Ticket',
                style: const TextStyle(
                  color: kcWhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Color _getPaymentMethodColor(PaymentMethodType type) {
    switch (type) {
      case PaymentMethodType.applePay:
        return kcBlackColor;
      case PaymentMethodType.googlePay:
        return kcBlackColor;
      case PaymentMethodType.card:
        return kcBlackColor;
    }
  }

  String _getPaymentMethodIcon(PaymentMethodType type) {
    switch (type) {
      case PaymentMethodType.applePay:
        return apple;
      case PaymentMethodType.googlePay:
        return card;
      case PaymentMethodType.card:
        return card;
    }
  }

  @override
  CheckoutViewModel viewModelBuilder(BuildContext context) =>
      CheckoutViewModel();
}
