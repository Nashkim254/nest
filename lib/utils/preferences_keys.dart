class PreferenceKeys {
  // Authentication
  static const String authToken = 'auth_token';
  static const String refreshToken = 'refresh_token';
  static const String isLoggedIn = 'is_logged_in';
  static const String userInfo = 'user_info';

  // App Settings
  static const String appSettings = 'app_settings';
  static const String darkMode = 'dark_mode';
  static const String language = 'language';
  static const String firstTimeLaunch = 'first_time_launch';

  // Location
  static const String lastKnownLocation = 'last_known_location';
  static const String locationPermissionAsked = 'location_permission_asked';

  // Cache
  static const String cacheTimestamp = 'cache_timestamp';
  static const String cachedData = 'cached_data';

  // Onboarding
  static const String onboardingCompleted = 'onboarding_completed';

  // Notifications
  static const String notificationEnabled = 'notification_enabled';
  static const String pushToken = 'push_token';

  // Custom preferences - add your own keys here
  static const String customKey1 = 'custom_key_1';
  static const String customKey2 = 'custom_key_2';
}
