//
//  UserRepository.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/14.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift
import Moya

protocol UserRepositoryProtocol {
    func signin(email: String, password: String) -> Single<ResponseWrapper<UserInfo>>
}


class UserRepository: UserRepositoryProtocol {
    
    let provider: MoyaProvider<UserRouter>

    init(provider: MoyaProvider<UserRouter> = MoyaProvider<UserRouter>()) {
        self.provider = provider
    }
    
    func signin(email: String, password: String) -> Single<ResponseWrapper<UserInfo>> {
        return provider.rx
            .request(.signin(email: email, password: password))
            .map(ResponseWrapper<UserInfo>.self)
    }    
}
