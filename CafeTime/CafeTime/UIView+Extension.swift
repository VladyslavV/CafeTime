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
    
    func animateConstraintsTransition(withDuration dur: TimeInterval) {
        UIView.animate(withDuration: dur, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
}
