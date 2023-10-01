//
//  Permission.swift
//  Pods
//
//  Created by Jiten Patel on 01/10/23.
//

import UIKit
import Foundation

open class Permission {
    
    open var authorized: Bool {
        return status == .authorized
    }
    
    open var denied: Bool {
        return status == .denied
    }
    
    open var notDetermined: Bool {
        return status == .notDetermined
    }
    
    open var debugName: String {
        return type.name
    }

    @available(iOSApplicationExtension, unavailable)
    open func openSettingPage() {
        DispatchQueue.main.async {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: nil)
            }
        }
    }
    
    // MARK: Must Ovveride
    
    open var type: Permission.PermissionType {
        preconditionFailure("This method must be overridden.")
    }
    
    open var status: Permission.Status {
        preconditionFailure("This method must be overridden.")
    }
    
    open func request(completion: @escaping () -> ()) {
        preconditionFailure("This method must be overridden.")
    }
    
    open var canBePresentWithCustomInterface: Bool {
        return true
    }
    
    // MARK: Internal
    
    public init() {}
    
    // MARK: - Models
    
    @objc public enum Status: Int, CustomStringConvertible {
        
        case authorized
        case denied
        case notDetermined
        case notSupported
        
        public var description: String {
            switch self {
            case .authorized: return "authorized"
            case .denied: return "denied"
            case .notDetermined: return "not determined"
            case .notSupported: return "not supported"
            }
        }
    }
    
    public enum PermissionType {
        
        case camera
        case notification
        case photoLibrary
        case microphone
        case calendar(access: CalendarAccess)
        case contacts
        case reminders
        case speech
        // Upgrade location as calendar style
        case locationWhenInUse
        case locationAlways
        case motion
        case mediaLibrary
        case bluetooth
        case tracking
        case faceID
        case siri
        case health
        
        public var name: String {
            switch self {
            case .camera:
                return "Camera"
            case .photoLibrary:
                return "Photo Library"
            case .microphone:
                return "Microphone"
            case .calendar(access: .write), .calendar(access: .full):
                return "Calendar"
            case .contacts:
                return "Contacts"
            case .reminders:
                return "Reminders"
            case .speech:
                return "Speech"
            case .locationAlways:
                return "Location Always"
            case .motion:
                return "Motion"
            case .mediaLibrary:
                return "Media Library"
            case .bluetooth:
                return "Bluetooth"
            case .notification:
                return "Notification"
            case .locationWhenInUse:
                return "Location When Use"
            case .tracking:
                return "Tracking"
            case .faceID:
                return "FaceID"
            case .siri:
                return "Siri"
            case .health:
                return "Health"
            }
        }
    }
    
    public enum CalendarAccess {
        
        case full
        case write
    }
}

