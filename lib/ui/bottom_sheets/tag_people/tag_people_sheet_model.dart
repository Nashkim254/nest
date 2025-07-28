import 'package:flutter/material.dart';
import 'package:nest/models/people_model.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class TagPeopleSheetModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  TextEditingController searchController = TextEditingController();
  void closeSheet() {
    _bottomSheetService.completeSheet(SheetResponse(
      confirmed: false,
    ));
  }

  void tag() {
    _bottomSheetService.completeSheet(SheetResponse(
      confirmed: true,
      data: tagged,
    ));
  }

  List<People> tagged = [];
  final List<People> users = [
    People(name: "John Doe", imageUrl: avatar, role: 'user'),
    People(name: "Jane Smith", imageUrl: avatar, role: 'user'),
    People(name: "Alice Johnson", imageUrl: avatar, role: 'user'),
    People(name: "Bob Brown", imageUrl: avatar, role: 'user'),
    People(name: "Charlie White", imageUrl: avatar, role: 'user'),
    People(name: "David Green", imageUrl: avatar, role: 'user'),
    People(name: "Eva Black", imageUrl: avatar, role: 'user'),
    People(name: "Frank Blue", imageUrl: avatar, role: 'user'),
    People(name: "Grace Yellow", imageUrl: avatar, role: 'user'),
    People(name: "Hannah Purple", imageUrl: avatar, role: 'user'),
    People(name: "Ian Orange", imageUrl: avatar, role: 'user'),
    People(name: "Jack Pink", imageUrl: avatar, role: 'user'),
    People(name: "Kathy Cyan", imageUrl: avatar, role: 'user'),
    People(name: "Leo Magenta", imageUrl: avatar, role: 'user'),
    People(name: "Mia Gray", imageUrl: avatar, role: 'user'),
    People(name: "Nina Brown", imageUrl: avatar, role: 'user'),
    People(name: "Oscar Silver", imageUrl: avatar, role: 'user'),
    People(name: "Paul Gold", imageUrl: avatar, role: 'user'),
    People(name: "Quinn Teal", imageUrl: avatar, role: 'user'),
    People(name: "Rita Coral", imageUrl: avatar, role: 'user'),
    People(name: "Sam Indigo", imageUrl: avatar, role: 'user'),
  ];

  onSearchChanged(String query) {
    if (searchController.text.isEmpty) {
      notifyListeners();
      return users;
    }
    users
        .where((user) => user.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
    notifyListeners();
  }

  List<People> get filteredUsers {
    if (searchController.text.isEmpty) {
      return users;
    }
    return users
        .where((user) => user.name
            .toLowerCase()
            .contains(searchController.text.toLowerCase()))
        .toList();
  }

  bool isUserTagged(int index) {
    return tagged.any((user) => user.name == filteredUsers[index].name);
  }

  void toggleTagUser(People user, int index) {
    if (isUserTagged(index)) {
      tagged.remove(user);
      notifyListeners();
    } else {
      tagged.add(user);
      notifyListeners();
    }
  }
}
