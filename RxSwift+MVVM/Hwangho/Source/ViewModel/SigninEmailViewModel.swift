//
//  SigninViewModel.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/17.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift


class SigninEmailViewModel: ViewModelType {
    
    struct Input {
        let emailTextField = BehaviorSubject<String>(value: "")
        
        let nextButton = PublishSubject<Void>()
        
        let saveData = PublishSubject<(String)>()
    }
    
    struct Output {
        let correctEmail = PublishSubject<Bool>()
        
        let respondedNext = PublishSubject<(Bool)>()
    }
    
    
    //MARK: Custom Variable
    
    let input = Input()
    
    let output = Output()
    
    let service: UserService
    
    var disposeBag = DisposeBag()

    
    //MARK: Life Cycle
    
    required init(service: UserService = UserService()) {
        self.service = service
        
        /// email check (True, false))
        input.emailTextField
            .map { self.checkEmail(email: $0)}
            .bind(to: output.correctEmail)
            .disposed(by: disposeBag)
        
        /// email check (True, false))
        input.nextButton
            .withLatestFrom(input.emailTextField)
            .map { self.trueEmail(email: $0) }
            .bind(to: output.respondedNext)
            .disposed(by: disposeBag)
        
        /// 이메일 체크!
        /*
         @@@@@@@@@@@@@@@@@@@@
         @@@@@@@@@@@@@@@@@@@@
         @@@@@@@@@@@@@@@@@@@@
         */
    }
    
    
    //MARK: Custom Function
    
    /// email check logic
    func checkEmail(email: String) -> Bool {
        let emailRegEx = "[a-zA-Z0-9-_.]+@[a-zA-Z0-9-_.]+\\.[a-zA-Z]{2,5}"
        let regex = try! NSRegularExpression(pattern: emailRegEx, options: .caseInsensitive)

        return regex.firstMatch(in: email, options: [], range: NSRange(email.startIndex..., in: email)) != nil
    }
    
    
    // 예제
    func trueEmail(email: String) -> Bool {
        return email == "bnso313@naver.com" ? true : false
    }
    
}



