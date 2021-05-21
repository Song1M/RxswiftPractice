//
//  ToastMessage.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/20.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation
import UIKit

class ToastMessage {
    public static let shared = ToastMessage()
    private init() {}
    func show(str: String) {
        if let window = UIApplication.shared.windows.first {
            let label = UILabel(frame: CGRect(x: 70, y: window.bounds.height - 120, width: window.bounds.width - 140, height: 40))
            label.text = str
            label.textColor = .brownGrey
            label.textAlignment = .center
            label.backgroundColor = .greyishBrown
            label.layer.cornerRadius = 12
            label.clipsToBounds = true
            window.addSubview(label)
            label.alpha = 0
            UIView.animate(withDuration: 1, animations: {
                label.alpha = 1
            }, completion: { _ in
                UIView.animate(withDuration: 1, animations: {
                    label.alpha = 0
                }, completion: { _ in
                    label.removeFromSuperview()
                })
            })
        }
    }
}
