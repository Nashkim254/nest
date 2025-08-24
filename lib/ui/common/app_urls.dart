import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrls {
  static final String baseUrl = Platform.isAndroid
      ? 'http://10.0.2.2:8080/api/v1'
      : 'http://localhost:8080/api/v1';

  // auth
  static final String baseAuthUrl = '$baseUrl/auth';
  static final String login = '$baseAuthUrl/login';
  static final String register = '$baseAuthUrl/register';
  static final String reQuestPasswordReset = '$baseAuthUrl/reset-password';
  static final String resetPassword = '$baseAuthUrl/reset-password/confirm';
  static final String userProfile = '$baseUrl/users/me';
  static final String recommendedUsers = '$baseUrl/users/recommendations';
  static final String searchUsers = '$baseUrl/users/search';
  static final String followUser = '$baseUrl/users';
  static final String updateProfile = '$baseUrl/users/update';
  static final String fetchPosts = '$baseUrl/posts';
  static final String createPost = '$baseUrl/posts/create';
  static final String deletePost = '$baseUrl/posts/delete';
  static final String cloudflareSignVideo =
      '$baseUrl/social/cloudflare/sign-video';
  static final String getUploadFileUrl = '$baseUrl/uploads/url';

  // Add more URLs as needed
  //organizations
  static final String organizations = '$baseUrl/organizations';
  static final String myOrganization = '$baseUrl/organizations/me';
  static final String updateOrganization = '$baseUrl/organizations/update';
//events
  static final String events = '$baseUrl/events';
  static final String createEvent = '$baseUrl/events/';
  static final String validateTicketPassword = '$baseUrl/events';
  static final String updateEvent = '$baseUrl/events';
  static final String deleteEvent = '$baseUrl/events';
  static final String myEventsUrl = '$baseUrl/events/my';
  static final String searchEventsUrl = '$baseUrl/events/search';

  //websockets
  static String websocketUrl = Platform.isAndroid
      ? 'ws://10.0.2.2:8080/api/v1/ws'
      : 'ws://localhost:8080/api/v1/ws';

  //tickets
  static final String tickets = '$baseUrl/tickets';
  static final String myTickets = '$baseUrl/events/tickets/my';

  //messaging
  static final String conversations = '$baseUrl/messaging/conversations';
  static final String sendMessage = '$baseUrl/messaging/messages';
  static final String createGroupConvo =
      '$baseUrl/messaging/conversations/group';

  //social
  static final String social = '$baseUrl/social';
  static final String createPosts = '$social/posts';
  static final String getUserPostsUrl = '$social/user/posts';

  static final String NEXT_PUBLIC_GOOGLE_ACCESS_ID =
      dotenv.env['NEXT_PUBLIC_GOOGLE_ACCESS_ID']!;
  static final String clientSecrete = dotenv.env['CLIENTSECRET']!;
  static final String clientID = dotenv.env['CLIENTID']!;
  static final String payPalID = dotenv.env['PAYPAL_ID']!;
  static const String payPalUrl =
      "https://www.paypal.com/donate?hosted_button_id=";
// Construct an Uri to Google's oauth2 endpoint
  final authUrl = Uri.https('www.googleapis.com', 'oauth2/v4/token');
  static final String callBackURL = dotenv.env['callBackURL']!;
  static final String callBackSchemaURL = dotenv.env['callBackSchemaURL']!;
  static final String NEXT_PUBLIC_GOOGLE_REDIRECT =
      dotenv.env['NEXT_PUBLIC_GOOGLE_REDIRECT']!;
  static final String NEXT_PUBLIC_APPLE_REDIRECT =
      dotenv.env['NEXT_PUBLIC_APPLE_REDIRECT']!;
  static final String NEXT_PUBLIC_APPLE_ACCESS_ID =
      dotenv.env['NEXT_PUBLIC_APPLE_ACCESS_ID']!;
  final callbackUrlScheme = NEXT_PUBLIC_GOOGLE_REDIRECT;
  static const String googleUrl = 'oauth/google';
  static const String appleApiUrl = 'oauth/apple';
  static String authorizationEndpoint =
      '''https://accounts.google.com/o/oauth2/v2/auth?
scope=email%20profile&
response_type=code&
state=
redirect_uri=$callBackURL
client_id=$NEXT_PUBLIC_GOOGLE_ACCESS_ID
grant_type=authorization_code''';

// Construct the url
  static final oAuthUrl =
      Uri.https('accounts.google.com', '/o/oauth2/v2/auth', {
    'response_type': 'code',
    'client_id': NEXT_PUBLIC_GOOGLE_ACCESS_ID,
    'redirect_uri': 'app.thedoor.studio://',
    'scope':
        'https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email',
  });
  static final appleUrl = Uri.https('appleid.apple.com', '/auth/authorize', {
    'response_type': 'code',
    'client_id': NEXT_PUBLIC_APPLE_ACCESS_ID,
    'redirect_uri': NEXT_PUBLIC_APPLE_REDIRECT,
    'response_mode': 'form_post',
    'scope': scope,
  });
  static const scope = "email name";
  static const state = "";
  String url =
      'https://accounts.google.com/o/oauth2/v2/auth?redirect_uri=$NEXT_PUBLIC_GOOGLE_REDIRECT&client_id=$NEXT_PUBLIC_GOOGLE_ACCESS_ID&access_type=offline&response_type=code&prompt=consent&scope=https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email';
}
