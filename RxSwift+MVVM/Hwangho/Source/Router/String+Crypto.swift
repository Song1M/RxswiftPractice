//
//  String+Crypto.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/13.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation
import CryptoSwift

extension String {
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }

    mutating func encrypt() -> String {
        let key = "fivesixseveneight#5sixseveneight"
        
//        let iv = key.randomString(length: 16)
        let iv: Array<UInt8> = [ 13, 47, 76, 99, 82, 70, 1, 0, 34, 51, 6, 98, 72, 61, 29, 13 ]
        
        var result: String = ""

        do {
            var rest = self.bytes.count % 16
            var text = self
            if rest != 0 {
                rest = 16 - rest
                for _ in 0..<rest {
                    text += " "
                }
            }

            let encrypted = try AES(key: Array(key.utf8), blockMode: CBC(iv: iv), padding: .noPadding).encrypt(Array(text.utf8))
            result = encrypted.toHexString()
        } catch {
            
        }

        return result
    }
}
