//
//  LoginRouter.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/13.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

import Moya

enum UserRouter {
    case signin(email: String, password: String)
}

extension UserRouter: TargetType {
    public var baseURL: URL {
        return URL(string: "http://api.5678.studio")!
    }

    public var method: Moya.Method {
        switch self {
        case .signin:
            return .post
        }
    }

    public var path: String {
        switch self {
        case .signin:
            return "/api/v1/login"
        }
    }

    var parameters: [String: Any] {
        switch self {
        
        case .signin(var email, var password):
            return [
                "email": email.encrypt(),
                "password": password.encrypt(),
                "deviceToken": DeviceInfoModel.shared.deviceToken ?? "",
                "uuid": KeychainManager.shared.uuid ?? "",
                "version": VersionManager.shared.appVersion
            ]
            
        default:
            return [:]
        }
    }

    public var task: Task {
        switch self {
        case .signin:
            return .requestParameters(
                parameters: self.parameters,
                encoding: JSONEncoding.default
            )
        default:
            return .requestPlain
        }
    }

    public var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }

    
    public var sampleData: Data {
        switch self {
        case .signin:
            return """
                {
                  "code": 0,
                  "data": {
                    "birth": "string",
                    "email": "string",
                    "gender": "FEMALE",
                    "id": 0,
                    "name": "string",
                    "profileImage": "string"
                  },
                  "msg": "string",
                  "success": true,
                  "title": "string"
                }
                """.data(using: .utf8)!

        default:
            return Data()
        }
    }
    
}
