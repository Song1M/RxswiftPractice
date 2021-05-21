//
//  ModelType.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/14.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation

protocol ModelType: Decodable {
    
}

extension ModelType {
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy = self.dateDecodingStrategy
        return decoder
    }
}
