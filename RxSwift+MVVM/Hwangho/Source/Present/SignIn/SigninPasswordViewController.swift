//
//  SigninPasswordViewController.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/18.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class SigninPasswordViewController: BaseViewController, Storyboard {

    //MARK: Custom Variable
    
    weak var coordinator: AppCoordinator?
    
    let viewModel = SigninPasswordViewModel()
    
    
    //MARK: Custom Outlet
    
    @IBOutlet weak var passwordTextField: UITextField! { didSet {
        passwordTextField.isSecureTextEntry = true
        passwordTextField.font = UIFont.notoSans(style: .Regular, size: 16)
        passwordTextField.textColor = .white
    } }
    
    @IBOutlet weak var titleLabel: UILabel! { didSet {
        titleLabel.text = "비밀번호를 입력해주세요."
        titleLabel.tintColor = .white
        titleLabel.font = UIFont.notoSans(style: .Medium, size: 24)
    } }
    
    @IBOutlet weak var textFieldBackView: UIView! { didSet {
        textFieldBackView.backgroundColor = .greyishBrown
        textFieldBackView.layer.cornerRadius = 5
    } }
    
    @IBOutlet weak var passwordCheckLabel: UILabel! { didSet {
        passwordCheckLabel.tintColor = .brownGrey
        passwordCheckLabel.font = UIFont.notoSans(style: .Regular, size: 12)
    } }
    
    @IBOutlet weak var nextButton: UIButton! { didSet {
        nextButton.backgroundColor = .blackGray
        nextButton.layer.cornerRadius = 5
        nextButton.titleLabel?.font = UIFont.notoSans(style: .Medium, size: 16)
        nextButton.tintColor = .brownGrey
        nextButton.isEnabled = false
    } }
    
    @IBOutlet weak var eyesButton: UIButton! { didSet {
        eyesButton.isSelected = true
    } }
    
    
    
    //MARK: Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if passwordTextField.text!.isEmpty {
            passwordTextField.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        passwordTextField.resignFirstResponder()
    }
    
    override func setupAttributes() {
        navigationUI()
    }

    override func setupBinding() {
        passwordCheck()
        hiddenText()
        nextButtonTap()
    }
    
    
    //MARK: Custom Function
    
    /// 비밀번호 형식에 맞게 잘 들어 갔을 때 체크하는 함수
    func passwordCheck() {
        /// 비밀번호 입력 값
        passwordTextField.rx.text
            .orEmpty
            .bind(to: viewModel.input.passwordText)
            .disposed(by: disposeBag)
        
        /// 비밀번호 형식 check
        self.viewModel.output.passwordCheck
            .bind { self.checkPasswordLabel($0) }
            .disposed(by: disposeBag)
        
    }
    
    func hiddenText() {
        eyesButton.rx.tap
            .scan(true) { (lastState, newValue) in
                  !lastState
            }
            .bind {
                self.passwordTextField.isSecureTextEntry = $0
                self.eyesButton.isSelected = $0
            }
            .disposed(by: disposeBag)
    }
    
    /// Next Button 눌렀을 떄 취해야 될 행동
    func nextButtonTap() {
        /// next Button tap
        nextButton.rx.tap
            .bind(to: viewModel.input.nextButtonTap)
            .disposed(by: disposeBag)
        
        viewModel.output.respondedNext
            .subscribe(onNext: {
                if $0 {
                    self.coordinator?.birthDatecheck()
                } else {
                    
                }
            })
            .disposed(by: disposeBag)
        
        
    }
    
}


//MARK: - UI Logic

extension SigninPasswordViewController {
    
    /// 비밀번호 형식에 맞게 잘 들어 갔을 때 체크하는 함수
    func checkPasswordLabel(_ isTrue: Bool) {
        if isTrue {
            passwordCheckLabel.text = "영문, 숫자 조합 8자리 이상"
            passwordCheckLabel.textColor = .brownGrey
            nextButton.isEnabled = true
            nextButton.backgroundColor = .easterPurple
            nextButton.tintColor = .white
            
        } else {
            passwordCheckLabel.text = "영문, 숫자 조합 8자리 이상이어야 합니다."
            passwordCheckLabel.textColor = .coralPink
            nextButton.isEnabled = false
            nextButton.backgroundColor = .blackGray
            nextButton.tintColor = .brownGrey
        }
        
    }

}


//MARK: - Navigation

extension SigninPasswordViewController {
    
    func navigationUI() {
        navigationController?.navigationBar.tintColor = .white      // 버튼 색상
        navigationController?.navigationBar.barTintColor = .black   // Navigation Bar 색상
        navigationController?.navigationBar.isTranslucent = false   // navigation Bar 불투명
        navigationController?.navigationBar.isOpaque = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let backButtonImage = UIImage(named: "navigation_back_icon")
        navigationController?.navigationBar.backIndicatorImage = backButtonImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
    }
}
