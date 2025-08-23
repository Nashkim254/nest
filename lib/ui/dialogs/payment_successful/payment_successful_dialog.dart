import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'payment_successful_dialog_model.dart';


const double _graphicSize = 60;

class PaymentSuccessfulDialog
    extends StackedView<PaymentSuccessfulDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const PaymentSuccessfulDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  // Determine if this is a success or failure based on title/description content
  bool get _isSuccess {
    final title = request.title?.toLowerCase() ?? '';
    final description = request.description?.toLowerCase() ?? '';

    // Check for success keywords
    final successKeywords = ['success', 'successful', 'complete', 'completed', 'confirmed', 'approved'];
    final failureKeywords = ['failed', 'error', 'declined', 'rejected', 'unsuccessful', 'cancelled'];

    // Check if any success keywords are present
    bool hasSuccessKeywords = successKeywords.any((keyword) =>
    title.contains(keyword) || description.contains(keyword));

    // Check if any failure keywords are present
    bool hasFailureKeywords = failureKeywords.any((keyword) =>
    title.contains(keyword) || description.contains(keyword));

    // If both or neither, default based on explicit success indicators
    if (hasSuccessKeywords && !hasFailureKeywords) return true;
    if (hasFailureKeywords && !hasSuccessKeywords) return false;

    // Default to success if ambiguous
    return true;
  }

  // Get the appropriate icon based on payment state
  String get _icon => _isSuccess ? '✅' : '❌';

  // Get the appropriate background color for the icon
  Color get _iconBackgroundColor => _isSuccess
      ? const Color(0xFFE8F5E8)  // Light green
      : const Color(0xFFFFEBEE); // Light red

  // Get the appropriate button color
  Color get _buttonColor => _isSuccess
      ? Colors.black
      : kcRedColor; // Red for errors

  // Get the appropriate button text
  String get _buttonText => _isSuccess ? 'Got it' : 'Try Again';

  @override
  Widget builder(
      BuildContext context,
      PaymentSuccessfulDialogModel viewModel,
      Widget? child,
      ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: kcDarkColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.title ?? 'Payment Notification',
                        style: titleTextMedium.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      if (request.description != null) ...[
                        verticalSpaceTiny,
                        Text(
                          request.description!,
                          style: titleTextMedium.copyWith(
                            fontSize: 14,
                            color: kcGreyColor,
                          ),
                          maxLines: 3,
                          softWrap: true,
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  width: _graphicSize,
                  height: _graphicSize,
                  decoration: BoxDecoration(
                    color: _iconBackgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(_graphicSize / 2),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(_icon, style: const TextStyle(fontSize: 30)),
                )
              ],
            ),
            verticalSpaceMedium,
            GestureDetector(
              onTap: () => completer(DialogResponse(confirmed: _isSuccess)),
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _buttonColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  PaymentSuccessfulDialogModel viewModelBuilder(BuildContext context) =>
      PaymentSuccessfulDialogModel();
}
