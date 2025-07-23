import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/global_service.dart';

class NavigationViewModel extends ReactiveViewModel {
  final globalService = locator<GlobalService>();
  int get selectedHomeTabIndex => globalService.selectedHomeTabIndex;

  setSelectedHomeTabIndex(value) {
    globalService.setIndex = value;
    notifyListeners();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [globalService];
}
