import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../common/app_enums.dart';

class ReportSheetModel extends BaseViewModel {
  Function(SheetResponse)? _completer;
  ReportReason? _selectedReason;

  ReportReason? get selectedReason => _selectedReason;
  bool get canSubmit => _selectedReason != null;

  void initialize(Function(SheetResponse) completer) {
    _completer = completer;
  }

  void selectReason(ReportReason reason) {
    _selectedReason = reason;
    notifyListeners();
  }

  void submitReport() {
    if (!canSubmit || _completer == null) return;

    // Close sheet with selected reason
    _completer!(
      SheetResponse(
        confirmed: true,
        data: {
          'action': 'reported',
          'reason': _selectedReason!.displayName,
          'reasonEnum': _selectedReason!.name,
        },
      ),
    );
  }

  void closeSheet() {
    _completer?.call(SheetResponse(confirmed: false));
  }
}
