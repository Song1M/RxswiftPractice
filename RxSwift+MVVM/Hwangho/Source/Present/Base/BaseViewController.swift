//
//  BaseViewController.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/12.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import UIKit

import RxSwift


class BaseViewController: UIViewController {
    
    // MARK: Properties
    
    lazy private(set) var className: String = {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }()
    
    
    // MARK: Initializing
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupLifeCycleBinding()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupLifeCycleBinding()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLifeCycleBinding()
    }

    
    deinit {
        print("className: \(className)")
    }
    
    
    // MARK: Rx
    
    var disposeBag = DisposeBag()
    
    
    // MARK: Layout Constraints
    
    private(set) var didSetupConstraints = false
    
    override func viewDidLoad() {
        setupLayout()
        setupAttributes()
        setupLocalization()
        setupBinding()
        setData()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    func setupLayout() {
        // Override Layout.  => 레이아웃
    }
    
    func setupConstraints() {
        // Override Constraints. => 제약
    }
    
    func setupAttributes() {
        // Override Attributes  => 속성
    }
    
    func setupLocalization() {
        // Override Localization. => 현지화
    }
    
    func setupLifeCycleBinding() {
        // Override Binding for Lify Cycle Views
    }
    
    func setupBinding() {
        // Override Binding
    }
    
    func setData() {
        // Override Set Data
    }
    
}
