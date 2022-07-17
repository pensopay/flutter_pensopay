import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pensopay_ios_method_channel.dart';

abstract class PensopayIosPlatform extends PlatformInterface {
  /// Constructs a PensopayIosPlatform.
  PensopayIosPlatform() : super(token: _token);

  static final Object _token = Object();

  static PensopayIosPlatform _instance = MethodChannelPensopayIos();

  /// The default instance of [PensopayIosPlatform] to use.
  ///
  /// Defaults to [MethodChannelPensopayIos].
  static PensopayIosPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PensopayIosPlatform] when
  /// they register themselves.
  static set instance(PensopayIosPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
