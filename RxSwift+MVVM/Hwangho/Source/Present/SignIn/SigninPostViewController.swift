//
//  SigninPostViewController.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/20.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import UIKit

class SigninPostViewController: BaseViewController, Storyboard {
    
    
    //MARK: Custom Variable
    
    weak var coordinator: AppCoordinator?
    
    var viewModel = SigninPostViewModel()
    
    
    //MARK: Custom Outlet
    
    @IBOutlet weak var nameTextField: UITextField! { didSet {
        nameTextField.textColor = .white
        nameTextField.font = UIFont.notoSans(style: .Regular, size: 16)
    } }
    
    @IBOutlet weak var titleLabel: UILabel! { didSet {
        titleLabel.text = "이름이 무엇인가요?"
        titleLabel.tintColor = .white
        titleLabel.font = UIFont.notoSans(style: .Medium, size: 24)
    } }
    
    @IBOutlet weak var textFieldBackView: UIView! { didSet {
        textFieldBackView.backgroundColor = .greyishBrown
        textFieldBackView.layer.cornerRadius = 5
    } }
    
    @IBOutlet weak var nameCheckLabel: UILabel! { didSet {
        nameCheckLabel.text = "5678 프로필에 표시됩니다."
        nameCheckLabel.tintColor = .brownGrey
        nameCheckLabel.font = UIFont.notoSans(style: .Regular, size: 12)
    } }
    
    @IBOutlet weak var nextButton: UIButton! { didSet {
        nextButton.titleLabel?.text = "계정 만들기"
        nextButton.backgroundColor = .blackGray
        nextButton.layer.cornerRadius = 5
        nextButton.titleLabel?.font = UIFont.notoSans(style: .Medium, size: 16)
        nextButton.tintColor = .brownGrey
        nextButton.isEnabled = false
    } }
    
    @IBOutlet weak var termsToggle: UISwitch! { didSet {
        termsToggle.isOn = false
    } }
    
    @IBOutlet weak var privacyToggle: UISwitch! { didSet {
        privacyToggle.isOn = false
    } }
    
    
    //MARK: Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if nameTextField.text!.isEmpty {
            nameTextField.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        nameTextField.resignFirstResponder()
    }
    
    override func setupAttributes() {
        navigationUI()
    }
    
    override func setupBinding() {
        nameCheck()
        nextButtonTap()
    }
    
    
    //MARK: Custom Function
    
    /// name, Toggle 을 다 입력하고 체크 하였는지 확인!
    func nameCheck() {
        /// 이름
        nameTextField.rx.text
            .orEmpty
            .bind(to: viewModel.input.nameTextField)
            .disposed(by: disposeBag)
        
        /// Toggle
        termsToggle.rx.isOn
            .bind(to: viewModel.output.terms)
            .disposed(by: disposeBag)
        
        privacyToggle.rx.isOn
            .bind(to: viewModel.output.Privacy)
            .disposed(by: disposeBag)
        
        viewModel.output.nextButton
            .bind { self.checkNameTogle($0) }
            .disposed(by: disposeBag)
    }

    /// Next Button 눌렀을 떄 취해야 될 행동
    func nextButtonTap() {
        /// next Button tap
        
    }
    
    
}


//MARK: - UI Logic

extension SigninPostViewController {
    
    /// 비밀번호 형식에 맞게 잘 들어 갔을 때 체크하는 함수
    func checkNameTogle(_ isTrue: Bool) {
        if isTrue {
            nextButton.isEnabled = true
            nextButton.backgroundColor = .easterPurple
            nextButton.tintColor = .white
            
        } else {
            nextButton.isEnabled = false
            nextButton.backgroundColor = .blackGray
            nextButton.tintColor = .brownGrey
        }
    }
    
}


//MARK: - Navigation

extension SigninPostViewController {
    
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
