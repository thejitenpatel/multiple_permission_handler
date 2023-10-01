import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multiple_permission_handler/multiple_permission_handler_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelMultiplePermissionHandler platform = MethodChannelMultiplePermissionHandler();
  const MethodChannel channel = MethodChannel('multiple_permission_handler');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
