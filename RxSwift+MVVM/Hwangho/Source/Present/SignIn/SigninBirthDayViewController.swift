//
//  BirthDayViewController.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/20.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

class SigninBirthDayViewController: BaseViewController, Storyboard {
    
    //MARK: Custom Variable
    
    weak var coordinator: AppCoordinator?
    
    let viewModel = SigninBirthDayViewModel()
    
    let datePicker = UIDatePicker()
    
    
    //MARK: Custom Outlet
    
    @IBOutlet weak var dateTextField: UITextField! { didSet {
        dateTextField.font = UIFont.notoSans(style: .Regular, size: 16)
        dateTextField.textColor = .white
        dateTextField.tintColor = UIColor.clear
    } }
    
    @IBOutlet weak var titleLabel: UILabel! { didSet {
        titleLabel.text = "생년 월일이 언제인가요?"
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
        
        if dateTextField.text!.isEmpty {
            dateTextField.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dateTextField.resignFirstResponder()
    }
    
    override func setupLayout() {
        createDatePicker()
    }
    
    override func setupBinding() {
        checkBirthDay()
        nextButtonTap()
    }
    
    
    //MARK: IBAction
    
    @IBAction func textFieldDidTap(_ sender: Any) {
        createDatePicker()
    }

    
    //MARK: Custom Function
    
    func checkBirthDay() {
        dateTextField.rx.text
            .orEmpty
            .bind(to: viewModel.input.birthDateText)
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
                    self.coordinator?.genderCheck()
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

extension SigninBirthDayViewController {
    
    func createDatePicker(){
        //format the display of our datepicker
        datePicker.datePickerMode = .date
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.backgroundColor = .black2
        datePicker.setValue(UIColor.brownGrey, forKeyPath: "textColor")
        datePicker.setValue(false, forKeyPath: "highlightsToday")

        //create a toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        toolbar.barTintColor = .black1
        
        //add a done button on this toolbar
        let doneButton = UIBarButtonItem(title: "완료", style: .plain, target: nil, action: #selector(doneClicked))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        doneButton.tintColor = .white
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        
        dateTextField.inputAccessoryView = toolbar
        
        //assign date picker to our textfield
        dateTextField.inputView = datePicker

    }
    
    @objc func doneClicked(){
        //format the date display in textfield
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
    
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
        
    }
}
