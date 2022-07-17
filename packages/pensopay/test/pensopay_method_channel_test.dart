import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pensopay/pensopay_method_channel.dart';

void main() {
  MethodChannelPensopay platform = MethodChannelPensopay();
  const MethodChannel channel = MethodChannel('pensopay');

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
