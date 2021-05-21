//
//  Font.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/17.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Font

extension UIFont {
    
    enum notoStyle: String {
        case Black
        case Bold
        case Light
        case Medium
        case Regular
        case DemiLight
        case Thin
    }
    
    enum proximaStyle {
        case Black
        case Bold
        case Extrabold
        case Light
        case Medium
        case Semibold
        case Thin
    }
    
    static func notoSans(style: notoStyle = .Regular, size: CGFloat = 10) -> UIFont {
        return UIFont(name: "NotoSansCJKkr-\(style)", size: size)!
    }
    
    static func Proxima(style: proximaStyle = .Thin, size: CGFloat = 10) -> UIFont {
        return UIFont(name: "Proxima Nova \(style)", size: size)!
    }
}
