//
//  Global.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/14.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

import UIKit

struct Global {
    static var signinUser: UserInfo?
    static let networkHelper = NetworkHelper()

    
    static func setUser(with userData: UserInfo) {
        Global.signinUser = userData
        
        if let encodedUser = try? JSONEncoder().encode(userData) {
            UserDefaults.standard.set(encodedUser, forKey: "signinUser")
            UserDefaults.standard.synchronize()
        }
    }
}
