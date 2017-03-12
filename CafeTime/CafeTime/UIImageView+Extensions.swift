//
//  UIImageView+Extensions.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/14/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
    
    func darken(percent: Float) {
        
        let opacityView = UIView()
        opacityView.layer.backgroundColor = UIColor.black.cgColor
        opacityView.layer.opacity = percent
        
        self.addSubview(opacityView)
        
        opacityView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}
