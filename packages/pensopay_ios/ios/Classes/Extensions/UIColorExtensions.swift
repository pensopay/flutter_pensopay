//
//  UIColorExtensions.swift
//  PensopayExample
//
//  Created on 07/26/2022
//  Copyright © 2022 Pensopay. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(integerLiteral: red)/255.0, green: CGFloat(integerLiteral: green)/255.0, blue: CGFloat(integerLiteral: blue)/255.0, alpha: 1.0)
    }
    
}
