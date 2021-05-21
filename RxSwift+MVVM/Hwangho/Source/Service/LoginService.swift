//
//  LoginService.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/13.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import Moya

struct ErrorData: Codable {
    let statusCode: Int
    let error: String
    let message: String
}

enum UserServiceError: Error {
    case error(String)
    case defaultError

    var message: String? {
        switch self {
        case let .error(msg):
            return msg
        case .defaultError:
            return "잠시 후에 다시 시도해주세요."
        }
    }
}


protocol UserServiceProtocol {
    typealias UserResult<T> = Result<T, UserServiceError>
    
    func signin(email: String, password: String) -> Single<ResponseWrapper<UserInfo>?>
}


struct UserService: UserServiceProtocol {
    let repo: UserRepositoryProtocol

    init(repo: UserRepositoryProtocol = UserRepository()) {
        self.repo = repo
    }
    
    func signin(email: String, password: String) -> Single<ResponseWrapper<UserInfo>?> {
        return repo
            .signin(email: email, password: password)
            .map { $0 }
            .catchErrorJustReturn(nil)
    }
    
}
