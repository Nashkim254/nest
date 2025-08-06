import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../common/app_enums.dart';
import '../../common/app_styles.dart';
import 'report_sheet_model.dart';

class ReportSheet extends StackedView<ReportSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const ReportSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ReportSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: kcDarkColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ReportHeaderWidget(
              onClose: viewModel.closeSheet,
            ),
            Flexible(
              child: ReportOptionsListWidget(
                selectedReason: viewModel.selectedReason,
                onReasonSelected: viewModel.selectReason,
              ),
            ),
            ReportSubmitButtonWidget(
              canSubmit: viewModel.canSubmit,
              onSubmit: viewModel.submitReport,
            ),
          ],
        ),
      ),
    );
  }

  @override
  ReportSheetModel viewModelBuilder(BuildContext context) => ReportSheetModel();
  @override
  void onViewModelReady(ReportSheetModel viewModel) {
    viewModel.initialize(completer!);
  }
}

class ReportHeaderWidget extends StatelessWidget {
  final VoidCallback onClose;

  const ReportHeaderWidget({
    Key? key,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Report',
            style: TextStyle(
              color: kcWhiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: onClose,
            child: const Icon(
              Icons.close,
              color: kcWhiteColor,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}

// Report Options List Widget
class ReportOptionsListWidget extends StatelessWidget {
  final ReportReason? selectedReason;
  final Function(ReportReason) onReasonSelected;

  const ReportOptionsListWidget({
    Key? key,
    required this.selectedReason,
    required this.onReasonSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: ReportReason.values.length,
      itemBuilder: (context, index) {
        final reason = ReportReason.values[index];
        return ReportOptionItemWidget(
          reason: reason,
          isSelected: selectedReason == reason,
          onTap: () => onReasonSelected(reason),
        );
      },
    );
  }
}

// Individual Report Option Item
class ReportOptionItemWidget extends StatelessWidget {
  final ReportReason reason;
  final bool isSelected;
  final VoidCallback onTap;

  const ReportOptionItemWidget({
    Key? key,
    required this.reason,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFF333333),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            // Radio Button
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? kcPrimaryColor : kcOffGreyColor,
                  width: 2,
                ),
                color: isSelected ? kcPrimaryColor : Colors.transparent,
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(
                        Icons.circle,
                        size: 8,
                        color: kcWhiteColor
                        ,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 16),

            // Option Text
            Expanded(
              child: Text(
                reason.displayName,
                style: const TextStyle(
                  color: kcWhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Submit Button Widget
class ReportSubmitButtonWidget extends StatelessWidget {
  final bool canSubmit;
  final VoidCallback onSubmit;

  const ReportSubmitButtonWidget({
    Key? key,
    required this.canSubmit,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: canSubmit ? onSubmit : null,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: canSubmit ? kcPrimaryColor : kcOffGreyColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Submit Report',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: canSubmit ? kcWhiteColor : kcOffGreyColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// Bottom Sheet Type Enum (add to your existing enum)
enum BottomSheetType {
  // ... your existing types
  report,
}

// Setup method for bottom sheet service
void setupReportBottomSheet() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    // ... your existing builders
    BottomSheetType.report: (context, request, completer) =>
        ReportSheet(request: request, completer: completer),
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

// Usage Example in any ViewModel
class ExampleViewModel extends BaseViewModel {
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();

  Future<void> openReportSheet() async {
    final result = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.report,
      title: 'Report',
      data: {
        'postId': 'some_post_id',
        'userId': 'some_user_id',
      },
    );

    if (result?.confirmed == true) {
      final action = result!.data['action'];
      final reason = result.data['reason'];

      if (action == 'reported') {
        // Handle successful report
        print('User reported content for: $reason');
        _showSuccessMessage('Report submitted successfully');
      }
    }
  }

  void _showSuccessMessage(String message) {
    // Show snackbar or toast
    print(message);
  }
}
