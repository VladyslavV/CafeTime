//
//  UIView+Extension.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/27/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

extension UIView {    
    func addSubviews(_ subviews:[UIView]){
        
        for subview in subviews{
            subview.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(subview)
        }
    }
}
