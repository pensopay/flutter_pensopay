import 'package:flutter_test/flutter_test.dart';
import 'package:pensopay/pensopay.dart';
import 'package:pensopay/pensopay_platform_interface.dart';
import 'package:pensopay/pensopay_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPensopayPlatform 
    with MockPlatformInterfaceMixin
    implements PensopayPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PensopayPlatform initialPlatform = PensopayPlatform.instance;

  test('$MethodChannelPensopay is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPensopay>());
  });

  test('getPlatformVersion', () async {
    Pensopay pensopayPlugin = Pensopay();
    MockPensopayPlatform fakePlatform = MockPensopayPlatform();
    PensopayPlatform.instance = fakePlatform;
  
    expect(await pensopayPlugin.getPlatformVersion(), '42');
  });
}
