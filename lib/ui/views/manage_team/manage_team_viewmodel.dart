import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/models/add_team_member.dart';
import 'package:nest/models/events.dart';
import 'package:nest/services/event_service.dart';
import 'package:nest/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../models/organization_model.dart';
import '../../common/app_colors.dart';
import 'edit_organization_view.dart';

class ManageTeamViewModel extends BaseViewModel {
  List<Event> _organizationEvents = [];
  List<Event> get organizationEvents => _organizationEvents;
  final _navigationService = locator<NavigationService>();
  final userService = locator<UserService>();
  final eventService = locator<EventService>();
  final logger = Logger();
  int? organizationId;

  // Password dialog properties
  final passwordController = TextEditingController();
  bool _showPasswordDialogState = false;
  bool _showPassword = false;
  bool _isValidatingPassword = false;
  String _passwordError = '';
  Event? _currentPasswordProtectedEvent;

  bool get showPasswordDialogState => _showPasswordDialogState;
  bool get showPassword => _showPassword;
  bool get isValidatingPassword => _isValidatingPassword;
  String get passwordError => _passwordError;
  void initialize(Organization organization) {
    organizationId = organization.id ?? 0;
    print('Initializing with organization ID: ${organization.id}');
    print('Organization name: ${organization.name}');
    loadOrganizationEvents(organization.id);
    loadTeamMembers(organization);
  }

  loadTeamMembers(Organization organization) {
    _teamMembers = organization.teamMembers ?? [];
  }

  // Load events for the organization
  Future<void> loadOrganizationEvents(int? organizationId) async {
    if (organizationId == null) return;

    setBusy(true);
    try {
      // Fetch events using the EventService
      final response = await eventService.getMyEvents(page: 1, size: 50);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> eventsJson =
            response.data['events'] ?? response.data;

        // Convert JSON to Event objects and filter by organization
        final allEvents =
            eventsJson.map((eventJson) => Event.fromJson(eventJson)).toList();

        // Filter events by organization ID
        // If event has organization_id 0, it might be unassigned - show for current org
        _organizationEvents = allEvents
            .where((event) =>
                event.organizationId == organizationId ||
                event.organizationId == 0)
            .toList();

        print(
            'Loaded ${_organizationEvents.length} events for organization $organizationId (including unassigned events)');
      } else {
        print('Failed to load events: ${response.message}');
        _organizationEvents = [];
      }

      notifyListeners();
    } catch (e) {
      // Handle error
      print('Error loading events: $e');
      _organizationEvents = [];
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to load events: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  List<TeamMember> _teamMembers = [];

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

  onBackPressed() => locator<NavigationService>().back();

  void onSettingsPressed() {
    // Handle settings navigation
  }

  void onEditOrganizationPressed(Organization organization) async {
    final result = await _navigationService
        .navigateToView(EditOrganizationView(organization: organization));
    if (result == true) {
      initialize(organization);
    }
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

  // Event navigation with password handling
  void onEventTapped(Event event) {
    if (event.isPasswordProtected) {
      showPasswordDialog(event);
    } else {
      navigateToViewEvent(event);
    }
  }

  // Password dialog methods
  void showPasswordDialog(Event event) {
    _currentPasswordProtectedEvent = event;
    _showPasswordDialogState = true;
    _passwordError = '';
    passwordController.clear();
    notifyListeners();
  }

  void closePasswordDialog() {
    _showPasswordDialogState = false;
    _passwordError = '';
    _showPassword = false;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  Future<void> validatePassword() async {
    if (passwordController.text.isEmpty) {
      _passwordError = 'Please enter a password';
      notifyListeners();
      return;
    }

    if (_currentPasswordProtectedEvent == null) {
      _passwordError = 'Event not found';
      notifyListeners();
      return;
    }

    _isValidatingPassword = true;
    _passwordError = '';
    notifyListeners();

    try {
      closePasswordDialog();
      navigateToViewEvent(_currentPasswordProtectedEvent!);
    } catch (e, s) {
      _passwordError = 'Error validating password. Please try again.';
      logger.e('Password validation error: $s');
    } finally {
      _isValidatingPassword = false;
      notifyListeners();
    }
  }

  void navigateToViewEvent(Event event) {
    _navigationService.navigateToViewEventView(
      event: event,
      password: passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
