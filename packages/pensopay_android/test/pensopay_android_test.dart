import 'package:flutter_test/flutter_test.dart';
import 'package:pensopay_android/pensopay_android.dart';
import 'package:pensopay_android/pensopay_android_platform_interface.dart';
import 'package:pensopay_android/pensopay_android_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPensopayAndroidPlatform 
    with MockPlatformInterfaceMixin
    implements PensopayAndroidPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PensopayAndroidPlatform initialPlatform = PensopayAndroidPlatform.instance;

  test('$MethodChannelPensopayAndroid is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPensopayAndroid>());
  });

  test('getPlatformVersion', () async {
    PensopayAndroid pensopayAndroidPlugin = PensopayAndroid();
    MockPensopayAndroidPlatform fakePlatform = MockPensopayAndroidPlatform();
    PensopayAndroidPlatform.instance = fakePlatform;
  
    expect(await pensopayAndroidPlugin.getPlatformVersion(), '42');
  });
}
