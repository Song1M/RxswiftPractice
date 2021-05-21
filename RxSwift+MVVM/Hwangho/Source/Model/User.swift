//
//  User.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/12.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

// MARK: - Login
struct Login: Codable {
    let code: Int
    let data: UserInfo
    let msg: String
    let success: Bool
    let title: String
}

// MARK: - Data
struct UserInfo: Codable, Equatable {
    let birth: String?
    let email: String
    let gender: String?
    let id: Int
    let name: String
    let profileImage: String?
}

 
