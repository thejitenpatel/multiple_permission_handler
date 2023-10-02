//
//  SiriPermission.swift
//  integration_test
//
//  Created by Jiten Patel on 02/10/23.
//

import Foundation
import Intents

extension Permission {
    static var siri: SiriPermission {
        return SiriPermission()
    }
}

class SiriPermission: Permission {
    override var type: Permission.PermissionType {
        .siri
    }
    
    var usageDescriptionKey: String? { "NSSiriUsageDescription" }
    
    override var status: Permission.Status {
        switch INPreferences.siriAuthorizationStatus() {
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
        INPreferences.requestSiriAuthorization { _ in
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
