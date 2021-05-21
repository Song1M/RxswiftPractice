//
//  Color.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/17.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import Foundation
import UIKit


//MARK: - Color

extension UIColor {
    
    @nonobjc class var white: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var uglyYellow: UIColor {
        return UIColor(red: 210.0 / 255.0, green: 222.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var lightMint: UIColor {
        return UIColor(red: 176.0 / 255.0, green: 1.0, blue: 194.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var blackGray: UIColor {
        return UIColor(white: 50.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var black1: UIColor {
        return UIColor(white: 40.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var black2: UIColor {
        return UIColor(white: 33.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var brownGrey: UIColor {
        return UIColor(white: 160.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var greyishBrown: UIColor {
        return UIColor(white: 80.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var easterPurple: UIColor {
        return UIColor(red: 195.0 / 255.0, green: 106.0 / 255.0, blue: 1.0, alpha: 1.0)
    }
    
    @nonobjc class var coralPink: UIColor {
        return UIColor(red: 1.0, green: 88.0 / 255.0, blue: 108.0 / 255.0, alpha: 1.0)
    }

}
