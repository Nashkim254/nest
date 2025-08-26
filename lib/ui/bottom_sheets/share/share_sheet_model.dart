import 'package:logger/logger.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../../services/share_service.dart';

class ShareSheetModel extends BaseViewModel {
  final bottomSheet = locator<BottomSheetService>();
  final snackbar = locator<SnackbarService>();
  Function(SheetResponse)? completer;
  final shareService = locator<ShareService>();
  Logger logger = Logger();
  copyLink({Function(SheetResponse)? completer}) async {
    var resource = await shareService.getSharePostLink(
        postId: '123',
        title: 'Sample Post',
        description: 'This is a sample post for sharing.',
        imageUrl: null);
    shareService.copyToClipboard(resource);
    //close the bottom sheet
    completer?.call(SheetResponse(confirmed: true));
    snackbar.showSnackbar(
      message: 'Copied to clipboard',
      duration: const Duration(seconds: 2),
    );
  }

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
