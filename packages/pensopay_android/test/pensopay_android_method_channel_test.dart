import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pensopay_android/pensopay_android_method_channel.dart';

void main() {
  MethodChannelPensopayAndroid platform = MethodChannelPensopayAndroid();
  const MethodChannel channel = MethodChannel('pensopay_android');

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
