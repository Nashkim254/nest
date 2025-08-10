import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_enums.dart';
import 'package:stacked/stacked.dart';

class FindPeopleAndOrgsViewModel extends BaseViewModel {
  final searchController = TextEditingController();
  String _searchQuery = '';
  FinderType finderType = FinderType.all;
  setFinderType(FinderType type) {
    finderType = type;
    print('Finder type set to: $finderType');
    notifyListeners();
  }

  set searchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  void onSearchChanged(String value) {
    searchQuery = value;
  }

  void submitSearch() {}
}
