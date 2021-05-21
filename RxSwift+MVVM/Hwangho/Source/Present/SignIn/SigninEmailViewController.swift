//
//  SigninViewController.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/17.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import UIKit


class SigninEmailViewController: BaseViewController, Storyboard {
    
    //MARK: Custom Variable
    
    weak var coordinator: AppCoordinator?
    
    var viewModel = SigninEmailViewModel()
    
    
    //MARK: Custom Outlet
    
    @IBOutlet weak var emailTextField: UITextField! { didSet {
        emailTextField.font = UIFont.notoSans(style: .Regular, size: 16)
        emailTextField.textColor = .white
    } }
    
    @IBOutlet weak var titleLabel: UILabel! { didSet {
        titleLabel.text = "이메일 주소가 무엇인가요?"
        titleLabel.font = UIFont.notoSans(style: .Medium, size: 24)
    } }
    
    @IBOutlet weak var emailCheckLabel: UILabel! { didSet {
        emailCheckLabel.text = "나중에 이 이메일 주소를 확인해야 합니다"
        emailCheckLabel.tintColor = .brownGrey
        emailCheckLabel.font = UIFont.notoSans(style: .Regular, size: 12)
    } }
    
    @IBOutlet weak var emailBackView: UIView! { didSet {
        emailBackView.layer.cornerRadius = 5
        emailBackView.backgroundColor = .greyishBrown
    } }
    
    @IBOutlet weak var nextButton: UIButton! { didSet{
        nextButton.layer.cornerRadius = 5
        nextButton.titleLabel?.font = UIFont.notoSans(style: .Medium, size: 16)
        self.nextButton.isEnabled = false
        self.nextButton.backgroundColor = .blackGray
        self.nextButton.tintColor = .brownGrey
    } }
    
    
    // MARK: Initializing
    
    init(viewModel: SigninEmailViewModel = SigninEmailViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        viewModel = SigninEmailViewModel()
        super.init(coder: coder)
    }
    
    
    //MARK: Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if emailTextField.text!.isEmpty {
            emailTextField.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        emailTextField.resignFirstResponder()
    }
    
    override func setupAttributes() {
        navigationUI()
    }
    
    override func setupBinding() {
        emailCheck()
        nextButtonTap()
    }
    
    
    //MARK: Custom Function
    
    func emailCheck() {
        /// email Text Label
        emailTextField.rx.text
            .orEmpty
            .bind(to: viewModel.input.emailTextField)
            .disposed(by: disposeBag)
        
        /// 이메일 형식 Label Check
        viewModel.output.correctEmail
            .subscribe(onNext: { self.checkEmailisTrue($0) })
            .disposed(by: disposeBag)
    }
    
    func nextButtonTap() {
        /// next Button tap
        nextButton.rx.tap
            .bind(to: viewModel.input.nextButton)
            .disposed(by: disposeBag)
        
        viewModel.output.respondedNext
            .subscribe(onNext: {
                if $0 {
                    
                    let vc = SigninPasswordViewController.instantiate(from: "Signin")
                    
                    self.viewModel.input.emailTextField
                        .bind(to: vc.viewModel.input.emailText)
                        .disposed(by: self.disposeBag)
                    
                    self.coordinator?.passWordCheck()
                } else {
                    
                }
            })
            .disposed(by: disposeBag)
    }
    
}


//MARK: - View Logic

extension SigninEmailViewController {
    
    /// 이메일 형식에 맞게 잘 들어 갔을 때 체크하는 함수
    func checkEmailisTrue(_ isTrue: Bool) {
        if isTrue {
            self.emailCheckLabel.text = "나중에 이 이메일 주소를 확인해야 합니다."
            self.emailCheckLabel.textColor = .brownGrey
            self.nextButton.isEnabled = true
            self.nextButton.backgroundColor = .easterPurple
            self.nextButton.tintColor = .white
            
        } else {
            self.emailCheckLabel.text = "정확한 이메일 주소를 입력하세요."
            self.emailCheckLabel.textColor = .coralPink
            self.nextButton.isEnabled = false
            self.nextButton.backgroundColor = .blackGray
            self.nextButton.tintColor = .brownGrey
        }
    }
}


//MARK: - Navigation

extension SigninEmailViewController {
    
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
