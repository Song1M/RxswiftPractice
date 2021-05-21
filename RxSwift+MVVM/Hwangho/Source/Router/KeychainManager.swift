//
//  KeychainManager.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/13.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation
import UIKit
import KeychainSwift


struct KeychainManager {
    
    static var shared = KeychainManager()
    
    var uuid: String? {
        let bundleID = Bundle.main.bundleIdentifier!
        let keychain = KeychainSwift(keyPrefix: "\(bundleID)_")
        return keychain.get("uuid")
    }
    
    
    private init() {}
    
    func setUUID() {
        let bundleID = Bundle.main.bundleIdentifier!
        let keychain = KeychainSwift(keyPrefix: "\(bundleID)_")
        
        if KeychainManager.shared.uuid == nil {
            keychain.set(DeviceInfoModel.shared.deviceUUID, forKey: "uuid")
        }
    }
}
