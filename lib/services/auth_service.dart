import 'package:nest/ui/common/app_urls.dart';
import 'package:stacked/stacked.dart';

import '../abstractClasses/abstract_class.dart';
import '../app/app.locator.dart';
import '../models/api_exceptions.dart';
import '../models/registration_model.dart';

class AuthService with ListenableServiceMixin {
  final IApiService _apiService = locator<IApiService>();

  Future register(RegistrationModel model) async {
    try {
      final response = await _apiService.post<RegistrationModel>(
        AppUrls.register,
        data: model.toJson(),
        parser: (data) => RegistrationModel.fromJson(data),
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }
}
