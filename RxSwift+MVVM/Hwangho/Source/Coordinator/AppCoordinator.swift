//
//  AppCoordinator.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/12.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import UIKit
import RxSwift


class AppCoordinator: NSObject, Coordinator {
    
    // MARK: Properties
    
    var parentCoordinateor: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    var navigation: UINavigationController
    
    
    init(presenter: UINavigationController) {
        self.navigation = presenter
        self.childCoordinators = []
    }
    
    // ScrollExampleViewController
    func start(animated: Bool) {
        let startViewController = StartViewController.instantiate(from: "Login")
        startViewController.coordinator = self
        navigation.pushViewController(startViewController, animated: false)
    }
    
    func login() {
        let loginViewController = LoginViewController.instantiate(from: "Login")
        loginViewController.coordinator = self
        navigation.pushViewController(loginViewController, animated: true)
    }
    
    func succes() {
        let succesViewController = SuccesViewController.instantiate(from: "Login")
        succesViewController.coordinator = self
        navigation.pushViewController(succesViewController, animated: true)
    }
    
    func signin() {
        let signinViewController = SigninEmailViewController.instantiate(from: "Signin")
        signinViewController.coordinator = self
        navigation.pushViewController(signinViewController, animated: true)
    }
    
    func passWordCheck() {
        let signinPasswordViewController = SigninPasswordViewController.instantiate(from: "Signin")
        signinPasswordViewController.coordinator = self
        navigation.pushViewController(signinPasswordViewController, animated: true)
    }
    
    func birthDatecheck() {
        let signinBirthDayViewController = SigninBirthDayViewController.instantiate(from: "Signin")
        signinBirthDayViewController.coordinator = self
        navigation.pushViewController(signinBirthDayViewController, animated: true)
    }
    
    func genderCheck() {
        let signinGenderViewController = SigninGenderViewController.instantiate(from: "Signin")
        signinGenderViewController.coordinator = self
        navigation.pushViewController(signinGenderViewController, animated: true)
    }
    
    func nickName() {
        let signinPostViewController = SigninPostViewController.instantiate(from: "Signin")
        signinPostViewController.coordinator = self
        navigation.pushViewController(signinPostViewController, animated: true)
    }
    


    func pop() {
        self.navigation.popViewController(animated: true)
    }
    
}

