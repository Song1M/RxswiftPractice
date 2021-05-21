//
//  StartViewController.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/12.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import UIKit

class StartViewController: BaseViewController, Storyboard {

    //MARK: Custom Variable
    
    weak var coordinator: AppCoordinator?
    
    
    //MARK: Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    //MARK: IBACtion
    
    @IBAction func loginDidTap(_ sender: Any) {
        self.coordinator?.login()
    }
    
    
    @IBAction func signinDidTap(_ sender: Any) {
        self.coordinator?.signin()
    }
    
}

