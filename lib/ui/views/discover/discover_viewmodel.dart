import 'package:nest/models/people_model.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_enums.dart';

class DiscoverViewModel extends BaseViewModel {
  DiscoverableType discoverableType = DiscoverableType.all;
  selectType(DiscoverableType type) {
    discoverableType = type;
    notifyListeners();
  }

  List<People> people = [
    People(
      name: 'DJ Electro',
      imageUrl: avatar,
      role: 'Artist / Techno',
    ),
    People(
      name: 'The Warehouse',
      imageUrl: avatar,
      role: 'Organization / Venue',
    ),
    People(
      name: 'Event Masters Inc.',
      imageUrl: avatar,
      role: 'Organization /Promoter',
    ),
    People(
      name: 'Luna Beats',
      imageUrl: avatar,
      role: 'Artist / House',
    ),
  ];
}
