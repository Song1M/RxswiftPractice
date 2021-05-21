//
//  Coordinator.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/12.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import UIKit


protocol Coordinator: AnyObject {
    
    var parentCoordinateor: Coordinator? { get set }
    
    var childCoordinators: [Coordinator] { get set }
    
    var navigation: UINavigationController { get set }

    
    // 컨트롤러 생성 및 화면 전환
    func start(animated: Bool)
    
}
