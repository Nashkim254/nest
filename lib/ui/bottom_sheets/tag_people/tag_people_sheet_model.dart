import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nest/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class TagPeopleSheetModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  final userService = locator<UserService>();
  List<UserSearchResult> userList = [];
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

  init(dynamic request) async {
    await getUserRecommendations();
  }

  List<UserSearchResult> tagged = [];

  onSearchChanged(String query) {
    if (searchController.text.isEmpty) {
      notifyListeners();
      return userList;
    }
    searchUsers(query);
    notifyListeners();
  }

  bool isUserTagged(int index) {
    return tagged.any((user) => user.id == userList[index].id);
  }

  void toggleTagUser(UserSearchResult user, int index) {
    if (isUserTagged(index)) {
      tagged.remove(user);
      notifyListeners();
    } else {
      tagged.add(user);
      notifyListeners();
    }
  }

  Logger logger = Logger();
  Future getUserRecommendations() async {
    setBusy(true);
    try {
      final response = await userService.getRecommendedUsers();
      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> usersJson = response.data['users'];
        logger
            .i('User recommendations loaded successfully: ${usersJson.length}');
        // Convert each JSON object to People model
        // users.clear();
        // users.addAll(usersJson.map((userJson) => People.fromJson(userJson)).toList());
        notifyListeners();
      } else {
        throw Exception(
            response.message ?? 'Failed to load user recommendations');
      }
    } catch (e, s) {
      logger.i('error: $e');
      logger.e('error: $s');

      locator<SnackbarService>().showSnackbar(
        message: 'Failed to load user recommendations: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  int page = 1;
  int size = 10;
  Future<List<UserSearchResult>> searchUsers(String query) async {
    setBusy(true);
    try {
      //add debouncer here

      final response =
          await userService.searchUsers(query: query, page: page, limit: size);
      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> usersJson = response.data['users'];
        logger
            .i('User recommendations loaded successfully: ${usersJson.length}');
        userList = usersJson
            .map((e) => UserSearchResult.fromJson(e))
            .toList(); // Convert each JSON object to People model
        notifyListeners();
        return userList;
      } else {
        throw Exception(
            response.message ?? 'Failed to load user recommendations');
      }
    } catch (e, s) {
      logger.i('error: $e');
      logger.e('error: $s');

      locator<SnackbarService>().showSnackbar(
        message: 'Failed to load user recommendations: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
    return userList;
  }
}

class UserSearchResult {
  final int id;
  final String firstName;
  final String lastName;
  final String role;
  final String profilePicture;
  final bool isPrivate;
  final double score;

  UserSearchResult({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.profilePicture,
    required this.isPrivate,
    required this.score,
  });

  factory UserSearchResult.fromJson(Map<String, dynamic> json) {
    return UserSearchResult(
      id: json['id'],
      firstName: json['first_name'],
      role: json['role'] ?? 'user',
      lastName: json['last_name'],
      profilePicture: json['profile_picture'] ?? '',
      isPrivate: json['is_private'],
      score: (json['score'] != null)
          ? (json['score'] as num).toDouble()
          : 0.0, // Handle null and ensure double type
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'role': role,
      'profile_picture': profilePicture,
      'is_private': isPrivate,
      'score': score,
    };
  }
}
