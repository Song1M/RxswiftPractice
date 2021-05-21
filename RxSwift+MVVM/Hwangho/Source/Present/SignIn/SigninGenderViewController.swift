//
//  SigninGenderViewController.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/20.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import UIKit

class SigninGenderViewController: BaseViewController, Storyboard {
    
    //MARK: Custom Variable
    
    weak var coordinator: AppCoordinator?
    
    let viewModel = SigninGenderViewModel()
    
    let gender = ["남자", "여자"]
    
    //MARK: Custom Outlet
    
    @IBOutlet weak var genderTextField: UITextField! { didSet {
        genderTextField.font = UIFont.notoSans(style: .Regular, size: 16)
        genderTextField.textColor = .white
        genderTextField.tintColor = UIColor.clear
    } }
    
    @IBOutlet weak var titleLabel: UILabel! { didSet {
        titleLabel.text = "성별이 무엇인가요?"
        titleLabel.font = UIFont.notoSans(style: .Medium, size: 24)
    } }
    
    @IBOutlet weak var dateBackView: UIView! { didSet {
        dateBackView.layer.cornerRadius = 5
        dateBackView.backgroundColor = .greyishBrown
    } }
    
    @IBOutlet weak var nextButton: UIButton! { didSet {
        nextButton.layer.cornerRadius = 5
        nextButton.titleLabel?.font = UIFont.notoSans(style: .Medium, size: 16)
        self.nextButton.isEnabled = false
        self.nextButton.backgroundColor = .blackGray
        self.nextButton.tintColor = .brownGrey
    } }
    
    
    //MARK: Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if genderTextField.text!.isEmpty {
            genderTextField.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        genderTextField.resignFirstResponder()
    }
    
    override func setupLayout() {
        
    }
    
    override func setupBinding() {
        checkBirthDay()
        nextButtonTap()
        
        createPickerView()
        dismissPickerView()
    }
    
    
    //MARK: Custom Function
    
    func checkBirthDay() {
        genderTextField.rx.text
            .orEmpty
            .bind(to: viewModel.input.genderText)
            .disposed(by: disposeBag)
        
        viewModel.output.nextButton
            .subscribe(onNext: { self.checkBirthDay($0) })
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
                    self.coordinator?.nickName()
                } else {
                    
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    /// 비밀번호 형식에 맞게 잘 들어 갔을 때 체크하는 함수
    func checkBirthDay (_ isTrue: Bool) {
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


//MARK: - Custom DatePicker

extension SigninGenderViewController: UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = gender[row]
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        pickerView.backgroundColor = .black2
        pickerView.setValue(UIColor.brownGrey, forKeyPath: "textColor")
//        pickerView.setValue(false, forKeyPath: "backgroundColor")
        
        genderTextField.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.barTintColor = .black1
        
        let button = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(self.action))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        button.tintColor = .white
        
        toolBar.setItems([flexibleSpace, button], animated: true)
        toolBar.isUserInteractionEnabled = true
       
        genderTextField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
        self.view.endEditing(true)
    }

}
