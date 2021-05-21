//
//  ViewModelType.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/18.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

import RxCocoa
import RxSwift

protocol ViewModelType {
    
    associatedtype Service
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    var input: Input { get }
    var output: Output { get }
    
    init(service: Service)
}
