import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'multiple_permission_handler_method_channel.dart';

abstract class MultiplePermissionHandlerPlatform extends PlatformInterface {
  /// Constructs a MultiplePermissionHandlerPlatform.
  MultiplePermissionHandlerPlatform() : super(token: _token);

  static final Object _token = Object();

  static MultiplePermissionHandlerPlatform _instance =
      MethodChannelMultiplePermissionHandler();

  /// The default instance of [MultiplePermissionHandlerPlatform] to use.
  ///
  /// Defaults to [MethodChannelMultiplePermissionHandler].
  static MultiplePermissionHandlerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MultiplePermissionHandlerPlatform] when
  /// they register themselves.
  static set instance(MultiplePermissionHandlerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> requestNotificationPermission() {
    throw UnimplementedError(
        'requestNotificationPermission() has not been implemented.');
  }

  Future<void> requestPhotoLibraryPermission() {
    throw UnimplementedError(
        'requestPhotoLibraryPermission() has not been implemented.');
  }

  Future<void> requestMultiplePermissions() {
    throw UnimplementedError(
        'requestMultiplePermissions() has not been implemented.');
  }

  Future<void> requestRemindersPermission() {
    throw UnimplementedError(
        'requestRemindersPermissions() has not been implemented.');
  }
}
