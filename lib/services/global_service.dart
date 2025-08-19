import 'package:stacked/stacked.dart';

import '../abstractClasses/abstract_class.dart';
import '../app/app.locator.dart';
import '../ui/common/app_urls.dart';

class GlobalService with ListenableServiceMixin {
  GlobalService() {
    [
      _selectedHomeTabIndex,
    ];
  }
  final IApiService _apiService = locator<IApiService>();

  int get selectedHomeTabIndex => _selectedHomeTabIndex;
  int _selectedHomeTabIndex = 0;
  set setIndex(int val) {
    _selectedHomeTabIndex = val;
    notifyListeners();
  }

  String getQueryParam(String ext) {
    return switch (ext) {
      'pdf' => 'application/pdf',
      'msword' => 'application/msword',
      'vnd.openxmlformats-officedocument.wordprocessingml.document' =>
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'jpeg' => 'image/jpeg',
      'jpg' => 'image/jpg',
      'png' => 'image/png',
      'gif' => 'image/gif',
      _ => 'image/jpeg',
    };
  }

  Future uploadFileGetURL(String extension) async {
    var response = await _apiService.get(AppUrls.getUploadFileUrl,
        queryParameters: {'content_type': getQueryParam(extension)});
    return response;
  }
}
