//
//  UIAlertAction+Extension.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/29/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

extension UIAlertController {
    func addActions(_ actions:[UIAlertAction]) {
        for action in actions {
            self.addAction(action)
        }
    }
}
