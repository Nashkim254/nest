import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked_annotations.dart';

import '../utils/preferences_keys.dart';

class SharedPreferencesService with InitializableDependency {
  static SharedPreferences? _preferences;
  static bool _initialized = false;

  // Public constructor for dependency injection
  SharedPreferencesService();

  @override
  Future<void> init() async {
    if (!_initialized) {
      _preferences = await SharedPreferences.getInstance();
      _initialized = true;
    }
  }

  /// Get SharedPreferences instance
  SharedPreferences get preferences {
    if (_preferences == null || !_initialized) {
      throw Exception(
          'SharedPreferencesService not initialized. Call initialise() first or ensure it\'s registered properly.');
    }
    return _preferences!;
  }

  /// Static method for manual singleton access if needed
  static SharedPreferencesService? _instance;
  static Future<SharedPreferencesService> getInstance() async {
    _instance ??= SharedPreferencesService();
    await _instance!.init();
    return _instance!;
  }

  // ===========================================
  // STRING OPERATIONS
  // ===========================================

  /// Save string value
  Future<bool> setString(String key, String value) async {
    return await preferences.setString(key, value);
  }

  /// Get string value
  String? getString(String key, {String? defaultValue}) {
    return preferences.getString(key) ?? defaultValue;
  }

  // ===========================================
  // INTEGER OPERATIONS
  // ===========================================

  /// Save integer value
  Future<bool> setInt(String key, int value) async {
    return await preferences.setInt(key, value);
  }

  /// Get integer value
  int? getInt(String key, {int? defaultValue}) {
    return preferences.getInt(key) ?? defaultValue;
  }

  // ===========================================
  // DOUBLE OPERATIONS
  // ===========================================

  /// Save double value
  Future<bool> setDouble(String key, double value) async {
    return await preferences.setDouble(key, value);
  }

  /// Get double value
  double? getDouble(String key, {double? defaultValue}) {
    return preferences.getDouble(key) ?? defaultValue;
  }

  // ===========================================
  // BOOLEAN OPERATIONS
  // ===========================================

  /// Save boolean value
  Future<bool> setBool(String key, bool value) async {
    return await preferences.setBool(key, value);
  }

  /// Get boolean value
  bool getBool(String key, {bool defaultValue = false}) {
    return preferences.getBool(key) ?? defaultValue;
  }

  // ===========================================
  // LIST OPERATIONS
  // ===========================================

  /// Save string list
  Future<bool> setStringList(String key, List<String> value) async {
    return await preferences.setStringList(key, value);
  }

  /// Get string list
  List<String>? getStringList(String key, {List<String>? defaultValue}) {
    return preferences.getStringList(key) ?? defaultValue;
  }

  // ===========================================
  // OBJECT/JSON OPERATIONS
  // ===========================================

  /// Save object as JSON string
  Future<bool> setObject(String key, Map<String, dynamic> value) async {
    String jsonString = jsonEncode(value);
    return await preferences.setString(key, jsonString);
  }

  /// Get object from JSON string
  Map<String, dynamic>? getObject(String key) {
    String? jsonString = preferences.getString(key);
    if (jsonString != null) {
      try {
        return jsonDecode(jsonString) as Map<String, dynamic>;
      } catch (e) {
        print('Error decoding JSON for key $key: $e');
        return null;
      }
    }
    return null;
  }

  /// Save list of objects as JSON
  Future<bool> setObjectList(
      String key, List<Map<String, dynamic>> value) async {
    String jsonString = jsonEncode(value);
    return await preferences.setString(key, jsonString);
  }

  /// Get list of objects from JSON
  List<Map<String, dynamic>>? getObjectList(String key) {
    String? jsonString = preferences.getString(key);
    if (jsonString != null) {
      try {
        List<dynamic> decoded = jsonDecode(jsonString) as List<dynamic>;
        return decoded.cast<Map<String, dynamic>>();
      } catch (e) {
        print('Error decoding JSON list for key $key: $e');
        return null;
      }
    }
    return null;
  }

  // ===========================================
  // UTILITY OPERATIONS
  // ===========================================

  /// Check if a key exists
  bool containsKey(String key) {
    return preferences.containsKey(key);
  }

  /// Remove a specific key
  Future<bool> remove(String key) async {
    return await preferences.remove(key);
  }

  /// Remove multiple keys
  Future<void> removeKeys(List<String> keys) async {
    for (String key in keys) {
      await preferences.remove(key);
    }
  }

  /// Clear all preferences
  Future<bool> clear() async {
    return await preferences.clear();
  }

  /// Get all keys
  Set<String> getAllKeys() {
    return preferences.getKeys();
  }

  /// Get all preferences as Map
  Map<String, dynamic> getAll() {
    Map<String, dynamic> allPrefs = {};
    Set<String> keys = preferences.getKeys();

    for (String key in keys) {
      dynamic value = preferences.get(key);
      allPrefs[key] = value;
    }

    return allPrefs;
  }

  // ===========================================
  // CONVENIENCE METHODS FOR COMMON USE CASES
  // ===========================================

  /// User authentication token
  Future<bool> setAuthToken(String token) async {
    return await setString(PreferenceKeys.authToken, token);
  }

  Future<bool> setExpiry(String token) async {
    return await setString(PreferenceKeys.authToken, token);
  }

  String? getAuthToken() {
    return getString(PreferenceKeys.authToken);
  }

  Future<bool> clearAuthToken() async {
    return await remove(PreferenceKeys.authToken);
  }

  /// User login status
  Future<bool> setIsLoggedIn(bool isLoggedIn) async {
    return await setBool(PreferenceKeys.isLoggedIn, isLoggedIn);
  }

  bool getIsLoggedIn() {
    return getBool(PreferenceKeys.isLoggedIn);
  }

  /// User information
  Future<bool> setUserInfo(Map<String, dynamic> userInfo) async {
    return await setObject(PreferenceKeys.userInfo, userInfo);
  }

  Map<String, dynamic>? getUserInfo() {
    return getObject(PreferenceKeys.userInfo);
  }

  /// App settings
  Future<bool> setAppSettings(Map<String, dynamic> settings) async {
    return await setObject(PreferenceKeys.appSettings, settings);
  }

  Map<String, dynamic>? getAppSettings() {
    return getObject(PreferenceKeys.appSettings);
  }

  /// First time app launch
  Future<bool> setFirstTimeLaunch(bool isFirstTime) async {
    return await setBool(PreferenceKeys.firstTimeLaunch, isFirstTime);
  }

  bool isFirstTimeLaunch() {
    return getBool(PreferenceKeys.firstTimeLaunch, defaultValue: true);
  }

  /// Theme mode
  Future<bool> setDarkMode(bool isDarkMode) async {
    return await setBool(PreferenceKeys.darkMode, isDarkMode);
  }

  bool getDarkMode() {
    return getBool(PreferenceKeys.darkMode);
  }

  /// Last known location
  Future<bool> setLastKnownLocation(String location) async {
    return await setString(PreferenceKeys.lastKnownLocation, location);
  }

  String? getLastKnownLocation() {
    return getString(PreferenceKeys.lastKnownLocation);
  }

  // ===========================================
  // BATCH OPERATIONS
  // ===========================================

  /// Save multiple preferences at once
  Future<void> setBatch(Map<String, dynamic> preferences) async {
    for (String key in preferences.keys) {
      dynamic value = preferences[key];

      if (value is String) {
        await setString(key, value);
      } else if (value is int) {
        await setInt(key, value);
      } else if (value is double) {
        await setDouble(key, value);
      } else if (value is bool) {
        await setBool(key, value);
      } else if (value is List<String>) {
        await setStringList(key, value);
      } else if (value is Map<String, dynamic>) {
        await setObject(key, value);
      } else if (value is List<Map<String, dynamic>>) {
        await setObjectList(key, value);
      }
    }
  }

  /// Get multiple preferences at once
  Map<String, dynamic> getBatch(List<String> keys) {
    Map<String, dynamic> result = {};

    for (String key in keys) {
      dynamic value = preferences.get(key);
      if (value != null) {
        result[key] = value;
      }
    }

    return result;
  }
}
