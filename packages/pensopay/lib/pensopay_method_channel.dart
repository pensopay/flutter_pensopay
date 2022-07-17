import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pensopay_platform_interface.dart';

/// An implementation of [PensopayPlatform] that uses method channels.
class MethodChannelPensopay extends PensopayPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('pensopay');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
