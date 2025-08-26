import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/models/organization_model.dart';
import 'package:nest/models/user_serach_ressult.dart';
import 'package:nest/services/global_service.dart';
import 'package:nest/services/user_service.dart';
import 'package:nest/ui/common/app_enums.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// Combined search result model for unified display

class FindPeopleAndOrgsViewModel extends ReactiveViewModel {
  final searchController = TextEditingController();
  final Logger logger = Logger();
  final UserService _userService = locator<UserService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final GlobalService _globalService = locator<GlobalService>();

  // Search state
  String _searchQuery = '';
  FinderType _finderType = FinderType.all;

  // Data storage
  List<UserSearchResult> _allUsers = [];
  List<Organization> _allOrganizations = [];
  List<SearchResultItem> _filteredResults = [];

  // Getters
  String get searchQuery => _searchQuery;
  FinderType get finderType => _finderType;
  List<SearchResultItem> get searchResults => _filteredResults;
  bool get hasResults => _filteredResults.isNotEmpty;
  bool get isSearching => _searchQuery.isNotEmpty;

  // Initialize the view model
  Future<void> initialize() async {
    setBusy(true);
    try {
      await Future.wait([
        _loadInitialUsers(),
        _loadUserOrganization(),
      ]);
      _updateFilteredResults();
    } catch (e) {
      logger.e('Failed to initialize: $e');
      _showError('Failed to load initial data');
    } finally {
      setBusy(false);
    }
  }

  // Set finder type and update results
  void setFinderType(FinderType type) {
    _finderType = type;
    logger.d('Finder type set to: $type');
    _updateFilteredResults();
    notifyListeners();
  }

  // Handle search input changes
  void onSearchChanged(String value) {
    _searchQuery = value.trim();
    logger.d('Search query changed: $_searchQuery');

    if (_searchQuery.isEmpty) {
      _updateFilteredResults();
    } else {
      _performSearch();
    }
    notifyListeners();
  }

  // Load initial recommended users
  Future<void> _loadInitialUsers() async {
    try {
      final response = await _userService.getRecommendedUsers();
      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> usersJson = response.data['users'];
        _allUsers = usersJson.map((e) => UserSearchResult.fromJson(e)).toList();
        logger.i('Loaded ${_allUsers.length} recommended users');
      } else {
        throw Exception(response.message ?? 'Failed to load recommended users');
      }
    } catch (e) {
      logger.e('Error loading initial users: $e');
      rethrow;
    }
  }

  // Load user's organization
  Future<void> _loadUserOrganization() async {
    try {
      final response = await _userService.getMyOrganization();
      if (response.statusCode == 200 && response.data != null) {
        final Organization organization =
            Organization.fromJson(response.data['organization']);
        _allOrganizations = [organization];
        logger.i('Loaded user organization: ${organization.name}');
      } else if (response.statusCode == 404) {
        _allOrganizations = [];
        logger.i('No user organization found');
      } else {
        throw Exception(response.message ?? 'Failed to load organization');
      }
    } catch (e) {
      logger.e('Error loading user organization: $e');
      // Don't rethrow here as organization is optional
    }
  }

  // Perform search based on current query and filter type
  Future<void> _performSearch() async {
    if (_searchQuery.isEmpty) return;

    setBusy(true);
    try {
      List<Future<void>> searchTasks = [];

      if (_finderType == FinderType.all || _finderType == FinderType.people) {
        searchTasks.add(_searchUsers());
      }

      if (_finderType == FinderType.all ||
          _finderType == FinderType.organizations) {
        searchTasks.add(_searchOrganizations());
      }

      await Future.wait(searchTasks);
      _updateFilteredResults();
    } catch (e) {
      logger.e('Search failed: $e');
      _showError('Search failed. Please try again.');
    } finally {
      setBusy(false);
    }
  }

  // Search for users
  Future<void> _searchUsers() async {
    try {
      final response = await _userService.searchUsers(
        query: _searchQuery,
        page: 1,
        limit: 20,
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> usersJson = response.data['users'];
        _allUsers = usersJson.map((e) => UserSearchResult.fromJson(e)).toList();
        logger.i('Found ${_allUsers.length} users for query: $_searchQuery');
      } else {
        throw Exception(response.message ?? 'Failed to search users');
      }
    } catch (e) {
      logger.e('Error searching users: $e');
      rethrow;
    }
  }

  // Search for organizations
  Future<void> _searchOrganizations() async {
    try {
      final response = await _userService.searchOrganization(q: _searchQuery);

      if (response.statusCode == 200 && response.data != null) {
        final Organization organization =
            Organization.fromJson(response.data['organization']);
        _allOrganizations = [organization];
        logger.i('Found organization: ${organization.name}');
      } else if (response.statusCode == 404) {
        _allOrganizations = [];
        logger.i('No organizations found for query: $_searchQuery');
      } else {
        throw Exception(response.message ?? 'Failed to search organizations');
      }
    } catch (e) {
      logger.e('Error searching organizations: $e');
      rethrow;
    }
  }

  // Update filtered results based on current filter type
  void _updateFilteredResults() {
    List<SearchResultItem> results = [];

    switch (_finderType) {
      case FinderType.people:
        results =
            _allUsers.map((user) => SearchResultItem.fromUser(user)).toList();
        break;
      case FinderType.organizations:
        results = _allOrganizations
            .map((org) => SearchResultItem.fromOrganization(org))
            .toList();
        break;
      case FinderType.all:
        results = [
          ..._allUsers.map((user) => SearchResultItem.fromUser(user)),
          ..._allOrganizations
              .map((org) => SearchResultItem.fromOrganization(org)),
        ];
        break;
    }

    _filteredResults = results;
    logger.d('Updated filtered results: ${_filteredResults.length} items');
  }

  // Handle follow action
  Future<void> followItem(SearchResultItem item) async {
    setBusy(true);
    try {
      if (item.isOrganization) {
        // Handle organization follow logic
        logger.i('Following organization: ${item.name}');
        // await _userService.followOrganization(item.id);
      } else {
        // Handle user follow logic
        logger.i('Following user: ${item.name}');
        await followUser(item.id);
        // await _userService.followUser(item.id);
      }
      _showSuccess('Successfully followed ${item.id}');
    } catch (e) {
      logger.e('Error following ${item.name}: $e');
      _showError('Failed to follow ${item.name}');
    } finally {
      setBusy(false);
    }
  }

  // Utility methods
  void _showError(String message) {
    _snackbarService.showSnackbar(
      message: message,
      duration: const Duration(seconds: 3),
    );
  }

  void _showSuccess(String message) {
    _snackbarService.showSnackbar(
      message: message,
      duration: const Duration(seconds: 2),
    );
  }

  // Clear search and reset to initial state
  void clearSearch() {
    searchController.clear();
    _searchQuery = '';
    initialize();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  followUser(int id) async {
    try {
      final response =
          await _userService.followUnfollowUser(id: id, isFollow: true);
      if (response.statusCode == 200) {
        logger.i('User followed successfully');
      } else {
        logger.e('Failed to follow user: ${response.message}');
      }
    } catch (e) {
      logger.e('Error following user: $e');
    }
  }

  goToOtherProfile(int userId) {
    _globalService.setOtherUserId = userId;
    locator<NavigationService>().navigateToProfileView(isOtherUser: true);
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [_globalService];
}
