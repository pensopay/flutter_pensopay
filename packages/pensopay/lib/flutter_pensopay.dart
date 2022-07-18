import 'package:flutter/services.dart';

import 'pensopay_platform_interface.dart';

class Pensopay {
  static const MethodChannel _channel = MethodChannel('pensopay');

  Future<String?> getPlatformVersion() {
    return PensopayPlatform.instance.getPlatformVersion();
  }

  static Future<void> init({required String apiKey}) async {
    _channel.invokeMethod('init', {'api-key': apiKey});
  }
}
