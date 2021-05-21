//
//  SigninBirthDayViewModel.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/20.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

class SigninBirthDayViewModel: ViewModelType {
    
    
    struct Input {
        let birthDateText = BehaviorSubject<String>(value: "")
        
        let nextButtonTap = PublishSubject<Void>()

    }
    
    struct Output {
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
        
        input.birthDateText
            .map { $0 == "" ? false : true }
            .bind(to: output.nextButton)
            .disposed(by: disposeBag)
        
        input.nextButtonTap
            .withLatestFrom(input.birthDateText)
            .map { self.TrueBirthDate(date: $0) }
            .bind(to: output.respondedNext)
            .disposed(by: disposeBag)
        
    }
    
    func TrueBirthDate(date: String) -> Bool {
        return date == "" ? false : true
    }
    
    
}
