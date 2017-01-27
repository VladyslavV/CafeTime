//
//  Extensions.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/27/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import M13Checkbox

extension UIView {
    
    func addSubviews(_ subviews:[UIView]){
        
        for subview in subviews{
            subview.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(subview)
        }
    }
}

extension M13Checkbox {
    func isChecked() -> Bool {
        if self.checkState == .checked {
            return true
        } else {
            return false
        }
    }
}
