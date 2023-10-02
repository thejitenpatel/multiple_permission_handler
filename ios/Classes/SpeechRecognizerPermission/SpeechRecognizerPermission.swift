//
//  SpeechRecognizerPermission.swift
//  multiple_permission_handler
//
//  Created by Jiten Patel on 02/10/23.
//

import Foundation
import Speech

extension Permission {
    static var speech: SpeechRecognizerPermission{
        return SpeechRecognizerPermission()
    }
    
}

class SpeechRecognizerPermission: Permission {
    override var type: Permission.PermissionType {
        .speech
    }
    
    override var status: Permission.Status {
        switch SFSpeechRecognizer.authorizationStatus() {
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
        SFSpeechRecognizer.requestAuthorization { status in
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
