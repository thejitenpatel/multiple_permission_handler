//
//  NotificationPermission.swift
//  integration_test
//
//  Created by Jiten Patel on 01/10/23.
//

import Foundation
import UserNotifications

extension Permission {
    static var notification: NotificationPermission {
        return NotificationPermission()
    }
}

class NotificationPermission: Permission {
    override var type: Permission.PermissionType {
        .notification
    }
//    override var type: Permission.PermissionType {
//        .notification
//    }
//    
    override var status: Permission.Status {
        guard let authorizationStatus = fetchAuthorizationStatus() else { return .notDetermined }
        switch authorizationStatus {
        case .authorized:
            return .authorized
        case .denied:
            return .denied
        case .notDetermined:
            return .notDetermined
        case .provisional:
            return .authorized
        case .ephemeral:
            return .authorized
        @unknown default:
            return .denied
        }
    }
    
    private func fetchAuthorizationStatus() -> UNAuthorizationStatus? {
        var notificationSettings: UNNotificationSettings?
        let semaphore = DispatchSemaphore(value: 0)
        DispatchQueue.global().async {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                notificationSettings = settings
                semaphore.signal()
            }
        }
        semaphore.wait()
        return notificationSettings?.authorizationStatus
    }
    
    override func request(completion: @escaping () -> ()) {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .alert, .sound]) { granted, error in
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
