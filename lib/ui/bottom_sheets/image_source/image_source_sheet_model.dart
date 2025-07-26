import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../common/app_enums.dart';

class ImageSourceSheetModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();

  void selectSource(ImageSourceType sourceType) {
    _bottomSheetService.completeSheet(SheetResponse(
      confirmed: true,
      data: sourceType,
    ));
  }

  void cancel() {
    _bottomSheetService.completeSheet(SheetResponse(
      confirmed: false,
    ));
  }
}
