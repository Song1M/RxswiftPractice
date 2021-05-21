//
//  VersionManager.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/13.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation
import UIKit

import Alamofire


class VersionManager {
    
    static var shared = VersionManager()
    
    var appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    
}
