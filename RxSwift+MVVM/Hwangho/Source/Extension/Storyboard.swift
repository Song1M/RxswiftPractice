//
//  Storyboard.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/12.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import UIKit


/// 스토리보드용 초기화 프로토콜
@objc
protocol Storyboard {
    @objc optional static func instantiate() -> Self

}


extension Storyboard where Self: UIViewController {
    
    static func instantiate(from name: String = "Main") -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".").last ?? ""
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
    
}
