//
//  UITabBar+Extensions.swift
//  CafeTime
//
//  Created by Vladyslav Vyshnevksyy on 3/25/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

extension UITabBar {
    
    func transparentTabBar() {
        
        self.barTintColor = UIColor.clear
        self.isTranslucent = true
        self.backgroundImage = UIImage()
        self.shadowImage = UIImage()
    }
    
}
