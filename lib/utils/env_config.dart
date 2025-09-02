import 'dart:io';

import 'package:flutter/foundation.dart';

import '../ui/common/app_enums.dart';

class FlexibleApiConfig {
  static const String _developmentIP = '192.168.1.100'; // CHANGE THIS!
  static const String _port = '8080';

  // You can set this manually or detect it
  static bool _usePhysicalDevice = true; // Set to true when testing on physical device

  static void setPhysicalDevice(bool isPhysical) {
    _usePhysicalDevice = isPhysical;
  }

  static String get baseUrl {
    if (kReleaseMode) {
      return 'https://your-production-api.com/api/v1';
    }

    if (_usePhysicalDevice) {
      // Physical device - use computer's IP
      return 'http://$_developmentIP:$_port/api/v1';
    } else {
      // Emulator/Simulator
      if (Platform.isAndroid) {
        return 'http://10.0.2.2:$_port/api/v1';
      } else {
        return 'http://localhost:$_port/api/v1';
      }
    }
  }
}