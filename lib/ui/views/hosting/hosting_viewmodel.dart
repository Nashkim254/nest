import 'package:stacked/stacked.dart';

import '../../common/app_enums.dart';

class HostingViewModel extends BaseViewModel {
  HostingSelector? get selectedSelector => _selectedSelector;
  HostingSelector? _selectedSelector = HostingSelector.events;

  void selectType(HostingSelector type) {
    _selectedSelector = type;
    notifyListeners();
  }

  String getSelectorLabel(HostingSelector type) {
    switch (type) {
      case HostingSelector.events:
        return 'Events';
      case HostingSelector.analytics:
        return 'Analytics';
      case HostingSelector.quickActions:
        return 'Quick Actions';
    }
  }
}
