// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/bottom_sheets/add_location/add_location_sheet.dart';
import '../ui/bottom_sheets/image_source/image_source_sheet.dart';
import '../ui/bottom_sheets/notice/notice_sheet.dart';
import '../ui/bottom_sheets/tag_people/tag_people_sheet.dart';

enum BottomSheetType {
  notice,
  imageSource,
  addLocation,
  tagPeople,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.notice: (context, request, completer) =>
        NoticeSheet(request: request, completer: completer),
    BottomSheetType.imageSource: (context, request, completer) =>
        ImageSourceSheet(request: request, completer: completer),
    BottomSheetType.addLocation: (context, request, completer) =>
        AddLocationSheet(request: request, completer: completer),
    BottomSheetType.tagPeople: (context, request, completer) =>
        TagPeopleSheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
