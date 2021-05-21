//
//  SigninPostViewModel.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/20.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift


class SigninPostViewModel: ViewModelType {
    
    struct Input {
        let nameTextField = BehaviorSubject<String>(value: "")
        
        let nextButton = PublishSubject<Void>()
    }
    
    struct Output {
        let nameNext = PublishSubject<Bool>()
        
        let terms = PublishSubject<Bool>()
        
        let Privacy = PublishSubject<Bool>()
        
        let nextButton = PublishSubject<Bool>()
    }
    
    
    //MARK: Custom Variable
    
    let input = Input()
    
    let output = Output()
    
    let service: UserService
    
    var disposeBag = DisposeBag()

    
    //MARK: Life Cycle
    
    required init(service: UserService = UserService()) {
        self.service = service
        
        /// name 개수 체크
        input.nameTextField
            .map { self.nameCheck($0) }
            .bind(to: output.nameNext)
            .disposed(by: disposeBag)
        
        /// 이름, 토글 다 체크했을 때 Button Click 가능하도록!
        Observable
            .combineLatest(output.nameNext, output.terms, output.Privacy) {
                ($0, $1, $2) }
            .map{ $0 && $1 && $2}
            .bind(to: output.nextButton)
            .disposed(by: disposeBag)
        
        /// 이메일 체크!
        /*
         @@@@@@@@@@@@@@@@@@@@
         @@@@@@@@@@@@@@@@@@@@
         @@@@@@@@@@@@@@@@@@@@
         */
    }
    
    
    //MARK: Custom Function
    
    func nameCheck(_ name: String) -> Bool {
        return name.count>0 ? true : false
    }
}
