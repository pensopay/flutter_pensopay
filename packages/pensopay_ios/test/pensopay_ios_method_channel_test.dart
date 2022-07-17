import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pensopay_ios/pensopay_ios_method_channel.dart';

void main() {
  MethodChannelPensopayIos platform = MethodChannelPensopayIos();
  const MethodChannel channel = MethodChannel('pensopay_ios');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
