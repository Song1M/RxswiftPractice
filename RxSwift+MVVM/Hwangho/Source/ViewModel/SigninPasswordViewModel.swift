//
//  SigninPasswoardViewModel.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/18.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift


class SigninPasswordViewModel: ViewModelType {

    struct Input {
        let emailText = BehaviorSubject<String>(value: "")
        
        let passwordText = BehaviorSubject<String>(value: "")
        
        let nextButtonTap = PublishSubject<Void>()
    }
    
    struct Output {
        let passwordCheck = PublishSubject<Bool>()
        
        let respondedNext = PublishSubject<(Bool)>()
    }
    
    
    //MARK: Custom variable
    let input = Input()
    let output = Output()
    let service: UserService
    var disposeBag = DisposeBag()
    
    
    required init(service: UserService = UserService()) {
        self.service = service
        
        /// 들어온 Password 값을 가지고 체크
        input.passwordText
            .map { self.checkPassword(password: $0) }
            .bind(to: output.passwordCheck)
            .disposed(by: disposeBag)
        
        /// 페스워드 체크!
        /*
         @@@@@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@@@@ @@@@@@@@@@@@@@@@@@@@
        */
        input.nextButtonTap
            .withLatestFrom(input.passwordText)
            .map { self.truePassword(password: $0) }
            .bind(to: output.respondedNext)
            .disposed(by: disposeBag)
    }
    
    /// 이메일 체크가 잘 되었는지 확인하기
    func checkPassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*[0-9])(?=.*[a-z]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    // 예제
    func truePassword(password: String) -> Bool {
        return password == "aq5841rq" ? true : false
    }

}
