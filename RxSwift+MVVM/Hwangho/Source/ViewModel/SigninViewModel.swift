//
//  SigninViewModel.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/21.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation


import RxCocoa
import RxSwift


class SigninViewModel: ViewModelType {
    
    struct Input {
        let emailTextField = BehaviorSubject<String>(value: "")
        
        let passwordText = BehaviorSubject<String>(value: "")
        
        let birthDateText = BehaviorSubject<String>(value: "")
        
        let genderText = BehaviorSubject<String>(value: "")
        
        let nameTextField = BehaviorSubject<String>(value: "")
        
        let nextButton = PublishSubject<Void>()

    }
    
    struct Output {
        let correctEmail = PublishSubject<Bool>()
        
        let passwordCheck = PublishSubject<Bool>()
        
        let nextButton = PublishSubject<Bool>()
        
        let respondedNext = PublishSubject<Bool>()
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
        

        /// 들어온 Password 값을 가지고 체크
        input.passwordText
            .map { self.checkPassword(password: $0) }
            .bind(to: output.passwordCheck)
            .disposed(by: disposeBag)
        
        /// 페스워드 체크!
        input.nextButton
            .withLatestFrom(input.passwordText)
            .map { self.truePassword(password: $0) }
            .bind(to: output.respondedNext)
            .disposed(by: disposeBag)
        
        input.birthDateText
            .map { $0 == "" ? false : true }
            .bind(to: output.nextButton)
            .disposed(by: disposeBag)
        
        input.nextButton
            .withLatestFrom(input.birthDateText)
            .map { self.TrueBirthDate(date: $0) }
            .bind(to: output.respondedNext)
            .disposed(by: disposeBag)
        
        input.genderText
            .map { $0 == "" ? false : true }
            .bind(to: output.nextButton)
            .disposed(by: disposeBag)
        
        input.nextButton
            .withLatestFrom(input.genderText)
            .map { self.gender(date: $0) }
            .bind(to: output.respondedNext)
            .disposed(by: disposeBag)
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
    
    /// 이메일 체크가 잘 되었는지 확인하기
    func checkPassword(password: String) -> Bool {
        let passwordRegex = "^(?=.*[0-9])(?=.*[a-z]).{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    // 예제
    func truePassword(password: String) -> Bool {
        return password == "aq5841rq" ? true : false
    }
    
    func TrueBirthDate(date: String) -> Bool {
        return date == "" ? false : true
    }
    
    func gender(date: String) -> Bool {
        return date == "" ? false : true
    }

}
