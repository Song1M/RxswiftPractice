//
//  LoginViewController.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/12.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class LoginViewController: BaseViewController, Storyboard {

    //MARK: Custom Variable
    
    weak var coordinator: AppCoordinator?
    
    let viewModel = LoginViewModel()
    
    
    //MARK: Custom IBOutlet
    
    @IBOutlet weak var navigationBackButton: UIBarButtonItem!
    
    @IBOutlet weak var emailBackView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var emailCheckLabel: UILabel!
    
    @IBOutlet weak var passwordBackView: UIView!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordCheckLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    //MARK: Life Cycle
    
    override func setupLayout() {
        navigationCustom()
    }
    
    override func setupBinding() {
        navigationBackButton.rx.tap
            .subscribe(onNext: {[weak self] in
                self?.coordinator?.pop()
            }).disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind(to: viewModel.loginObservable)
            .disposed(by: disposeBag)
        
        viewModel.responseSignin
            .subscribe(onNext: { [weak self] response in
                
                if let code = response?.code,
                   let error = ErrorCode(rawValue: code),
                   error == .noneEmailAuth {
                    
                    print(error)
                    return
                }
                guard let result = response, result.success else {
                    self?.passwordCheckLabel.isHidden = false
                    self?.passwordCheckLabel.text = "이메일 및 비밀번호 조합이 잘못되었습니다."
                    return
                }
                self?.coordinator?.succes()
            })
            .disposed(by: disposeBag)
    }
    
    override func setData() {
        bindUI()
    }
    
    
    //MARK: Custom Function
    
    private func bindUI() {
        
        // Input 이메일 값 넘기기
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.emailTextObservable)
            .disposed(by: disposeBag)
        
        // 이메일 알맞게 다 적었는지
        viewModel.emailBoolObservable
            .bind(onNext: {
                self.chnageEmailBackViewColor(isTrue: $0)
                self.emailCheckLabel.isHidden = $0
            })
            .disposed(by: disposeBag)
        
        // Input 비밀번호 값 넘기기
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.passwordTextObservable)
            .disposed(by: disposeBag)
        
        // 비밀번호를 입력 했느가?
        viewModel.passwordBoolObservable
            .bind(onNext: {
                self.chnagePasswordBackViewColor(isTrue: $0)
                self.passwordCheckLabel.isHidden = $0
            })
            .disposed(by: disposeBag)
        
        // 두개 모두 입력을 잘 했는가??
        viewModel.loginBoolObservable
            .bind(onNext: {
                self.changeLoginButtonColor(isTrue: $0)
                self.loginButton.isEnabled = $0
        })
        .disposed(by: disposeBag)
    }
    
    // 로그인 버튼 색상 변경
    func changeLoginButtonColor(isTrue: Bool) {
        if isTrue {
            loginButton.backgroundColor = .purple
        } else {
            loginButton.backgroundColor = .gray
        }
    }
    
    // 이메일 backView 색상 변경
    func chnageEmailBackViewColor(isTrue: Bool) {
        if isTrue {
            emailBackView.backgroundColor = .gray
        } else {
            emailBackView.backgroundColor = .white
        }
    }
    
    // 비밀번호 backView 색상 변경
    func chnagePasswordBackViewColor(isTrue: Bool) {
        if isTrue {
            passwordBackView.backgroundColor = .gray
        } else {
            passwordBackView.backgroundColor = .white
        }
    }
    
}


// MARK: - NavigationBar

extension LoginViewController {
    
    //MARK: Custom function
    
    private func navigationCustom() {
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
}
