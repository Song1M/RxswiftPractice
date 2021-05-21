//
//  LoginViewModel.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/12.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

class LoginViewModel {
    
    //MARK: Custom Variable

    var emailTextObservable = BehaviorSubject<String>(value: "")
    
    var passwordTextObservable = BehaviorSubject<String>(value: "")
    
    var emailBoolObservable = BehaviorSubject<Bool>(value: false)
    
    var passwordBoolObservable = BehaviorSubject<Bool>(value: false)
    
    var loginBoolObservable = BehaviorSubject<Bool>(value: false)
    
    var loginObservable = PublishSubject<Void>()
    
    let responseSignin = PublishSubject<ResponseWrapper<UserInfo>?>()
    
    let disposeBag = DisposeBag()
    
    let service: UserServiceProtocol
    
    
    init(service: UserServiceProtocol = UserService()) {
        
        self.service = service
        
        emailTextObservable.distinctUntilChanged()
            .map{ self.checkEmail($0) }
            .bind(to: emailBoolObservable)
            .disposed(by: disposeBag)
        
        passwordTextObservable.distinctUntilChanged()
            .map{ self.checkPassword($0) }
            .bind(to: passwordBoolObservable)
            .disposed(by: disposeBag)
        
        Observable
            .combineLatest(emailBoolObservable, passwordBoolObservable) {
                ($0, $1) }
            .map{ $0 && $1 }
            .bind(to: loginBoolObservable)
            .disposed(by: disposeBag)
        
        let checkSign = Observable.combineLatest(emailTextObservable, passwordTextObservable) {
                ($0, $1)}
            .share()
        
        loginObservable
            .withLatestFrom(checkSign)
            .flatMapLatest(service.signin)
            .map { response -> ResponseWrapper<UserInfo>? in
                
                if let user = response?.data {
                    if let encodedUser = try? JSONEncoder().encode(user) {
                        Global.signinUser = user
                        UserDefaults.standard.set(encodedUser, forKey: "signinUser")
                    }
                    
                    CookieManager.shared.setCookie()
                }
                
                return response
            }
            .bind(to: responseSignin)
            .disposed(by: disposeBag)
    }
    
    
    //MARK: Custom function
    
    // Logic
    private func checkEmail(_ email: String) -> Bool {
        return (email.contains("@") && email.contains("."))
    }
    
    private func checkPassword(_ password: String) -> Bool {
        return password.count > 0
    }
}


struct LoginUser {
    let email: String?
    let passWord: String?
}

enum ErrorCode: Int {
    case noneEmailAuth = -1020
}
