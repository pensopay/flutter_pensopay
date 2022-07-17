
import 'pensopay_ios_platform_interface.dart';

class PensopayIos {
  Future<String?> getPlatformVersion() {
    return PensopayIosPlatform.instance.getPlatformVersion();
  }
}
