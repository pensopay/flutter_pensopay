import 'pensopay_platform_interface.dart';

class Pensopay {
  Future<String?> getPlatformVersion() {
    return PensopayPlatform.instance.getPlatformVersion();
  }
}
