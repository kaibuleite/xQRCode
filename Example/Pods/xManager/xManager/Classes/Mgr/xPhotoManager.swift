//
//  xPhotoManager.swift
//  xManager
//
//  Created by Mac on 2021/6/19.
//

import UIKit
import Photos

public class xPhotoManager: NSObject { 
    
    // MARK: - Public Property
    /// 是否授权了相册读写
    public var isGetAlbumAuthorization : Bool
    {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            return true // 未决定
        case .authorized:
            return true // 获得授权
        default:
            return false
        }
    }
}
