import 'package:nest/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';

class ShareSheetModel extends BaseViewModel {
  final bottomSheet = locator<BottomSheetService>();
  Function(SheetResponse)? completer;

  copyLink() {}
  shareViaDM() {}
  report() {
    completer?.call(SheetResponse(confirmed: false));
    final result = bottomSheet.showCustomSheet(
      variant: BottomSheetType.report,
      title: 'Report',
    );
    result.then(
      (value) {
        if (value != null && value.confirmed) {}
      },
    );
  }

  List<Map<String, dynamic>> socials = [
    {
      'name': 'Facebook',
      'icon': instagram,
    },
    {
      'name': 'Instagram',
      'icon': instagram,
    },
    {
      'name': 'X',
      'icon': x,
    },
    {
      'name': 'WhatsApp',
      'icon': whatsapp,
    },
  ];
  // copyLink(){}
}
