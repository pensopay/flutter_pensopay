import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pensopay_android_method_channel.dart';

abstract class PensopayAndroidPlatform extends PlatformInterface {
  /// Constructs a PensopayAndroidPlatform.
  PensopayAndroidPlatform() : super(token: _token);

  static final Object _token = Object();

  static PensopayAndroidPlatform _instance = MethodChannelPensopayAndroid();

  /// The default instance of [PensopayAndroidPlatform] to use.
  ///
  /// Defaults to [MethodChannelPensopayAndroid].
  static PensopayAndroidPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PensopayAndroidPlatform] when
  /// they register themselves.
  static set instance(PensopayAndroidPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
