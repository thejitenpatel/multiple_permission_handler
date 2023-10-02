//
//  AppTrackingPermission.swift
//  multiple_permission_handler
//
//  Created by Jiten Patel on 02/10/23.
//

import Foundation
import AppTrackingTransparency

@available(iOS 14, *)
extension Permission {
    static var appTracking: AppTrackingPermission {
        return AppTrackingPermission()
    }
}


@available(iOS 14, *)
class AppTrackingPermission: Permission {
    
    override var type: Permission.PermissionType {
        .appTracking
    }
    var usageDescriptionKey: String? { "NSUserTrackingUsageDescription" }
    
    override var status: Permission.Status {
        switch ATTrackingManager.trackingAuthorizationStatus {
        case .authorized:
            return .authorized
        case .denied:
            return .denied
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .denied
        @unknown default:
            return .denied
        }
    }
    
    override func request(completion: @escaping () -> ()) {
        ATTrackingManager.requestTrackingAuthorization { _ in
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
