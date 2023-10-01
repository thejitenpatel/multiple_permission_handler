
import 'multiple_permission_handler_platform_interface.dart';

class MultiplePermissionHandler {
  Future<String?> getPlatformVersion() {
    return MultiplePermissionHandlerPlatform.instance.getPlatformVersion();
  }

  Future<void> requestNotificationPermission() {
    return MultiplePermissionHandlerPlatform.instance.requestNotificationPermission();
  }
}
