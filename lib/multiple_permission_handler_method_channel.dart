import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'multiple_permission_handler_platform_interface.dart';

/// An implementation of [MultiplePermissionHandlerPlatform] that uses method channels.
class MethodChannelMultiplePermissionHandler
    extends MultiplePermissionHandlerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('multiple_permission_handler');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> requestNotificationPermission() async {
    final permission =
        await methodChannel.invokeMethod("requestNotificationPermission");
    return permission;
  }
}
