import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pensopay_method_channel.dart';

abstract class PensopayPlatform extends PlatformInterface {
  /// Constructs a PensopayPlatform.
  PensopayPlatform() : super(token: _token);

  static final Object _token = Object();

  static PensopayPlatform _instance = MethodChannelPensopay();

  /// The default instance of [PensopayPlatform] to use.
  ///
  /// Defaults to [MethodChannelPensopay].
  static PensopayPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PensopayPlatform] when
  /// they register themselves.
  static set instance(PensopayPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
