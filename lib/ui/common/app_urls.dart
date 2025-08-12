class AppUrls {
  static const String baseUrl = 'http://10.0.2.2:8080/api/v1';

  // auth
  static const String baseAuthUrl = '$baseUrl/auth';
  static const String login = '$baseAuthUrl/login';
  static const String register = '$baseAuthUrl/register';
  static const String userProfile = '$baseUrl/user/profile';
  static const String updateProfile = '$baseUrl/user/update';
  static const String fetchPosts = '$baseUrl/posts';
  static const String createPost = '$baseUrl/posts/create';
  static const String deletePost = '$baseUrl/posts/delete';

  // Add more URLs as needed
}
