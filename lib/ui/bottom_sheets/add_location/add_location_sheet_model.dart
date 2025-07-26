import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class AddLocationSheetModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  TextEditingController searchController = TextEditingController();
  void closeSheet() {
    _bottomSheetService.completeSheet(SheetResponse(
      confirmed: false,
    ));
  }

  void selectLocation(String location) {
    _bottomSheetService.completeSheet(SheetResponse(
      confirmed: true,
      data: location,
    ));
  }

  final List<String> usStates = [
    "Alabama",
    "Alaska",
    "Arizona",
    "Arkansas",
    "California",
    "Colorado",
    "Connecticut",
    "Delaware",
    "Florida",
    "Georgia",
    "Hawaii",
    "Idaho",
    "Illinois",
    "Indiana",
    "Iowa",
    "Kansas",
    "Kentucky",
    "Louisiana",
    "Maine",
    "Maryland",
    "Massachusetts",
    "Michigan",
    "Minnesota",
    "Mississippi",
    "Missouri",
    "Montana",
    "Nebraska",
    "Nevada",
    "New Hampshire",
    "New Jersey",
    "New Mexico",
    "New York",
    "North Carolina",
    "North Dakota",
    "Ohio",
    "Oklahoma",
    "Oregon",
    "Pennsylvania",
    "Rhode Island",
    "South Carolina",
    "South Dakota",
    "Tennessee",
    "Texas",
    "Utah",
    "Vermont",
    "Virginia",
    "Washington",
    "West Virginia",
    "Wisconsin",
    "Wyoming"
  ];
  List<String> get filteredStates {
    if (searchController.text.isEmpty) {
      return usStates;
    }

    return usStates
        .where((state) =>
            state.toLowerCase().contains(searchController.text.toLowerCase()))
        .toList();
  }

  onSearchChanged(String value) {
    if (searchController.text.isEmpty) {
      notifyListeners();
      return usStates;
    }
    usStates
        .where((state) =>
            state.toLowerCase().contains(searchController.text.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
