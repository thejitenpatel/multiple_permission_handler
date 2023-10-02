import 'package:flutter_test/flutter_test.dart';
import 'package:multiple_permission_handler/multiple_permission_handler.dart';
import 'package:multiple_permission_handler/multiple_permission_handler_method_channel.dart';
import 'package:multiple_permission_handler/multiple_permission_handler_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMultiplePermissionHandlerPlatform
    with MockPlatformInterfaceMixin
    implements MultiplePermissionHandlerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> requestNotificationPermission() => Future.value();
}

void main() {
  final MultiplePermissionHandlerPlatform initialPlatform =
      MultiplePermissionHandlerPlatform.instance;

  test('$MethodChannelMultiplePermissionHandler is the default instance', () {
    expect(initialPlatform,
        isInstanceOf<MethodChannelMultiplePermissionHandler>());
  });

  test('getPlatformVersion', () async {
    MultiplePermissionHandler multiplePermissionHandlerPlugin =
        MultiplePermissionHandler();
    MockMultiplePermissionHandlerPlatform fakePlatform =
        MockMultiplePermissionHandlerPlatform();
    MultiplePermissionHandlerPlatform.instance = fakePlatform;

    expect(await multiplePermissionHandlerPlugin.getPlatformVersion(), '42');
  });

  // test('requestNotificationPermission', () async {
  //   MultiplePermissionHandler multiplePermissionHandlerPlugin =
  //       MultiplePermissionHandler();
  //   MockMultiplePermissionHandlerPlatform fakePlatform =
  //       MockMultiplePermissionHandlerPlatform();
  //   MultiplePermissionHandlerPlatform.instance = fakePlatform;

  //   expect(await multiplePermissionHandlerPlugin.requestNotificationPermission(), '42');
  // });
}
