import 'package:flutter/material.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/models/add_team_member.dart';
import 'package:nest/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/organization_model.dart';
import '../../common/app_colors.dart';

class ManageTeamViewModel extends BaseViewModel {
  List<dynamic> _organizationEvents = [];
  List<dynamic> get organizationEvents => _organizationEvents;
  final _navigationService = locator<NavigationService>();
  final userService = locator<UserService>();
  int? organizationId;
  void initialize(Organization organization) {
    organizationId = organization.id ?? 0;
    loadOrganizationEvents(organization.id);
    loadTeamMembers(organization);
  }

  loadTeamMembers(Organization organization) {}
  // Load events for the organization
  Future<void> loadOrganizationEvents(int? organizationId) async {
    if (organizationId == null) return;

    setBusy(true);
    try {
      // Replace with your actual API call
      // final events = await userService.getMyOrganizationEvents();
      // _organizationEvents = events;

      // For now, using mock data
      _organizationEvents = [
        {
          'id': 1,
          'title': 'Crypto Trading Workshop',
          'description': 'Learn the basics of cryptocurrency trading',
          'date': 'Dec 15, 2024',
          'status': 'upcoming'
        },
        {
          'id': 2,
          'title': 'Blockchain Meetup',
          'description': 'Network with other blockchain enthusiasts',
          'date': 'Dec 20, 2024',
          'status': 'upcoming'
        }
      ];

      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error loading events: $e');
    }
    setBusy(false);
  }

  final List<TeamMember> _teamMembers = [];

  String _inviteEmail = '';

  List<TeamMember> get teamMembers => _teamMembers;
  String get inviteEmail => _inviteEmail;

  void updateInviteEmail(String email) {
    _inviteEmail = email;
    notifyListeners();
  }

  Future<void> addNewMember(int userId) async {
    if (_inviteEmail.isEmpty) return;

    setBusy(true);

    try {
      final newMember =
          AddTeamMemberInput(userId: userId, role: 'member', permissions: [
        'view',
      ]);
      final response =
          await userService.addTeamMember(organizationId!, newMember);
      if (response.statusCode == 200 || response.statusCode == 201) {}
      notifyListeners();
    } catch (e) {
      // Handle error
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void onBackPressed() {
    locator<NavigationService>().back();
  }

  void onSettingsPressed() {
    // Handle settings navigation
  }

  Color getRoleColor(String? role) {
    switch (role) {
      case 'admin':
        return kcPrimaryColor; // Orange-red
      case 'editor':
        return kcPrimaryColor; // Orange-red
      case 'viewer':
        return kcPrimaryColor; // Orange-red
      default:
        return kcPrimaryColor; // Default color
    }
  }

  // Create new event
  void onCreateEventPressed() {
    _navigationService.navigateTo(Routes.createEventView);
    print('Navigate to create event');
  }

  // Handle event options (edit, delete, etc.)
  void onEventOptionsPressed(dynamic event) {
    // Show bottom sheet or dialog with event options
    print('Event options for: ${event['title']}');
  }
}
