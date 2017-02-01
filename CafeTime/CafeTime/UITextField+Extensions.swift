//
//  UITextField+Extensions.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/30/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

extension UITextField {
    
    class func cleanFields(_ textFields: [UITextField]) {
        for textField in textFields {
            textField.text = ""
        }
    }
}

