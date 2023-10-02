//
//  RemindersPermission.swift
//  multiple_permission_handler
//
//  Created by Jiten Patel on 02/10/23.
//

import Foundation
import EventKit

extension Permission {
    static var reminders: RemindersPermission {
        return RemindersPermission()
    }
}

class RemindersPermission: Permission {
    override var type: Permission.PermissionType {
        .reminders
    }
    
    override var status: Permission.Status {
        switch EKEventStore.authorizationStatus(for: EKEntityType.reminder) {
        case .authorized:
            return .authorized
        case .denied:
            return .denied
        case .fullAccess:
            return .authorized
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .denied
        case .writeOnly:
            return .authorized
        @unknown default:
            return .denied
        }
    }
    
    override func request(completion: @escaping () -> ()) {
        let eventStore = EKEventStore()
        
        if #available(iOS 17.0, *) {
            eventStore.requestFullAccessToReminders { granted, error in
                DispatchQueue.main.async {
                    completion()
                }
            }
        } else {
            eventStore.requestAccess(to: EKEntityType.reminder) { granted, error in
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
}
