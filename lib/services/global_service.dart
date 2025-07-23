import 'package:stacked/stacked.dart';

class GlobalService with ListenableServiceMixin {
  GlobalService() {
    [
      _selectedHomeTabIndex,
    ];
  }
  int get selectedHomeTabIndex => _selectedHomeTabIndex;
  int _selectedHomeTabIndex = 0;
  set setIndex(int val) {
    _selectedHomeTabIndex = val;
    notifyListeners();
  }
}
