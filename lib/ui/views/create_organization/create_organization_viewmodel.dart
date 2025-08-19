import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nest/models/organization_model.dart';
import 'package:nest/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class CreateOrganizationViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final userService = locator<UserService>();
  final TextEditingController organizationNameController =
      TextEditingController();
  final TextEditingController organizationSocialController =
      TextEditingController();
  final TextEditingController organizationContactController =
      TextEditingController();
  final TextEditingController businessController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  Logger logger = Logger();
  addSocialMediaLink() {
    if (organizationSocialController.text.isNotEmpty) {
      organizationSocialController.text;
    }
  }

  String profilePic = '';
  String banner = '';

  List<TeamMember> teamMembers = [];
  addTeamMember(TeamMember member) {
    if (!teamMembers.contains(member)) {
      teamMembers.add(member);
      organizationContactController.clear();
      notifyListeners();
    }
  }

  removeTeamMember(int index) {
    teamMembers.removeAt(index);
    notifyListeners();
  }

//get list of strings from comma separated string or space
  List<String> getTeamMembersFromString(String members) {
    return members.split(',').map((e) => e.trim()).toList();
  }

  //genres
  List<String> getGenresFromString(String genres) {
    return genres.split(',').map((e) => e.trim()).toList();
  }

  //countries
  List<String> getCountriesFromString(String countries) {
    return countries.split(',').map((e) => e.trim()).toList();
  }

  Future createOrganizations() async {
    setBusy(true);
    try {
      Organization organization = Organization(
          name: organizationNameController.text,
          profilePic: profilePic,
          bio: bioController.text,
          genres: getGenresFromString(genreController.text),
          countries: getCountriesFromString(countryController.text),
          teamMembers: teamMembers,
          banner: banner);
      final response =
          await userService.createOrganization(organization: organization);
      if (response.statusCode == 200 && response.data != null) {
        logger.i('My Organizations: ${response.data}');
      } else if (response.statusCode == 404) {
        logger.w('No organizations found');
        notifyListeners();
      } else {
        // Handle error response
        logger.e('Failed to load organizations: ${response.message}');
        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to load organizations',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      // Handle exception
    } finally {
      setBusy(false);
    }
  }
}
