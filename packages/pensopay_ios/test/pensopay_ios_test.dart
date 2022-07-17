import 'package:flutter_test/flutter_test.dart';
import 'package:pensopay_ios/pensopay_ios.dart';
import 'package:pensopay_ios/pensopay_ios_platform_interface.dart';
import 'package:pensopay_ios/pensopay_ios_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPensopayIosPlatform 
    with MockPlatformInterfaceMixin
    implements PensopayIosPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PensopayIosPlatform initialPlatform = PensopayIosPlatform.instance;

  test('$MethodChannelPensopayIos is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPensopayIos>());
  });

  test('getPlatformVersion', () async {
    PensopayIos pensopayIosPlugin = PensopayIos();
    MockPensopayIosPlatform fakePlatform = MockPensopayIosPlatform();
    PensopayIosPlatform.instance = fakePlatform;
  
    expect(await pensopayIosPlugin.getPlatformVersion(), '42');
  });
}
