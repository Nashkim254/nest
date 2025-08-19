import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrls {
  static const String baseUrl = 'http://10.0.2.2:8080/api/v1';

  // auth
  static const String baseAuthUrl = '$baseUrl/auth';
  static const String login = '$baseAuthUrl/login';
  static const String register = '$baseAuthUrl/register';
  static const String reQuestPasswordReset = '$baseAuthUrl/reset-password';
  static const String resetPassword = '$baseAuthUrl/reset-password/confirm';
  static const String userProfile = '$baseUrl/users/me';
  static const String followUser = '$baseUrl/users';
  static const String updateProfile = '$baseUrl/users/update';
  static const String fetchPosts = '$baseUrl/posts';
  static const String createPost = '$baseUrl/posts/create';
  static const String deletePost = '$baseUrl/posts/delete';
  static const String getUploadFileUrl = '$baseUrl/uploads/url';

  // Add more URLs as needed
  //organizations
  static const String organizations = '$baseUrl/organizations';
  static const String myOrganization = '$baseUrl/organizations/me';
  static const String updateOrganization = '$baseUrl/organizations/update';

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
