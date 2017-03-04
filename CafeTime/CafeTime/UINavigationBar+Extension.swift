//
//  UINavigationBar+Extension.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/23/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

extension UINavigationBar {
    
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
    
    func resetToDefault() {
        self.setBackgroundImage(nil, for: .default)
        self.shadowImage = nil
        self.isTranslucent = false
    }
}
