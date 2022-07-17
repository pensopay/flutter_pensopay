import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pensopay_android_platform_interface.dart';

/// An implementation of [PensopayAndroidPlatform] that uses method channels.
class MethodChannelPensopayAndroid extends PensopayAndroidPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('pensopay_android');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
