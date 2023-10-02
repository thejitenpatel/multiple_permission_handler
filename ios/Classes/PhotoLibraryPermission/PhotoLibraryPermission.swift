//
//  PhotoLibraryPermission.swift
//  multiple_permission_handler
//
//  Created by Jiten Patel on 01/10/23.
//

import Foundation
import Photos

extension Permission {
    static var photoLibraryPermission: PhotoLibraryPermission {
        return PhotoLibraryPermission()
    }
    
}

class PhotoLibraryPermission: Permission {
    override var type: Permission.PermissionType {
        .photoLibrary
    }
    
    var fullAccessUsageDescriptionKey: String? {
        "NSPhotoLibraryUsageDescription"
    }
    
    var addingOnlyUsageDescriptionKey: String? {
        "NSPhotoLibraryAddUsageDescription"
    }
    
    public override var status: Permission.Status {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized: return .authorized
        case .denied: return .denied
        case .notDetermined: return .notDetermined
        case .restricted: return .denied
        case .limited: return .authorized
        @unknown default: return .denied
        }
    }
    
    public override func request(completion: @escaping () -> ()) {
        PHPhotoLibrary.requestAuthorization({
            finished in
            DispatchQueue.main.async {
                completion()
            }
        })
    }
    
}
