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
        case "requestPhotoLibraryPermission":
            Permission.photoLibraryPermission.request {}
        case "requestRemindersPermission":
            Permission.reminders.request {}
        case "requestSiriPermission":
            Permission.siri.request {}
        case "requestSpeechPermission":
            Permission.speech.request {}
        case "requestAppTrackingPermission":
            if #available(iOS 14, *) {
                Permission.appTracking.request {}
            }
        case "requestMultiplePermissions":
            Permission.notification.request {
                Permission.photoLibraryPermission.request {}
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

