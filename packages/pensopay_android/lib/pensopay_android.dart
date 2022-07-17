
import 'pensopay_android_platform_interface.dart';

class PensopayAndroid {
  Future<String?> getPlatformVersion() {
    return PensopayAndroidPlatform.instance.getPlatformVersion();
  }
}
