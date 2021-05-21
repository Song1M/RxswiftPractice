//
//  ResponseWrapper.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/14.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

struct ResponseWrapper<T: Decodable & Equatable>: ModelType, Decodable {
    var success: Bool
    var code: Int
    var title: String?
    var msg: String
    var data: T?
}


extension ResponseWrapper: Equatable {
    
    static func == (lhs: ResponseWrapper<T>, rhs: ResponseWrapper<T>) -> Bool {
        return lhs.data == rhs.data
    }
    
}
