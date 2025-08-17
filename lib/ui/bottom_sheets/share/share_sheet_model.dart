import 'package:nest/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../../services/share_service.dart';

class ShareSheetModel extends BaseViewModel {
  final bottomSheet = locator<BottomSheetService>();
  Function(SheetResponse)? completer;
  final shareService = locator<ShareService>();
  copyLink() {}
  shareViaDM() {
    ShareService.sharePost(
      title: 'Share via DM',
      postId: '123',
      description: 'Check this out!',
    );
  }

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
      'icon': fb,
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
