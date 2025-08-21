import 'dart:io';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../abstractClasses/abstract_class.dart';
import '../app/app.locator.dart';
import '../ui/common/app_urls.dart';
import 'package:path/path.dart' as p;

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
      '.pdf' => 'application/pdf',
      '.msword' => 'application/msword',
      'vnd.openxmlformats-officedocument.wordprocessingml.document' =>
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      '.jpeg' => 'image/jpeg',
      '.jpg' => 'image/jpg',
      '.png' => 'image/png',
      '.gif' => 'image/gif',
      _ => 'image/jpg',
    };
  }

  Future uploadFileGetURL(String extension, {String? folder}) async {
    var queryParameters = {
      'content_type': getQueryParam(extension),
      'folder': folder
    };
    Logger().i('Query Parameters: $queryParameters');
    var response = await _apiService.get(AppUrls.getUploadFileUrl,
        queryParameters: queryParameters);
    return response;
  }

  String getFileExtension(File file) {
    return p.extension(file.path); // includes the dot, e.g. ".jpg"
  }

  Future uploadFile(String uploadUrl, File file) async {
    final bytes = await file.readAsBytes();
    var response = await Dio().put(
      uploadUrl,
      data: bytes,
      options: Options(
        headers: {
          'Content-Type': 'application/octet-stream',
        },
      ),
    );
    return response;
  }
}
