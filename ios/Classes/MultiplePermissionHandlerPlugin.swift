import Flutter
import UIKit

public class MultiplePermissionHandlerPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "multiple_permission_handler", binaryMessenger: registrar.messenger())
        let instance = MultiplePermissionHandlerPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
 
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "requestNotificationPermission":
            Permission.notification.request {}
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
