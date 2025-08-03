import 'package:stacked/stacked.dart';

import '../../../models/people_model.dart';
import '../../common/app_enums.dart';
import '../../common/app_strings.dart';

class DiscoverFindPeopleViewModel extends BaseViewModel {
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
