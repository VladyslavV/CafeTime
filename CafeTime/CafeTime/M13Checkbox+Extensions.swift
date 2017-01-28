//
//  Extensions.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/27/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import M13Checkbox

extension M13Checkbox {
    func isChecked() -> Bool {
        if self.checkState == .checked {
            return true
        } else {
            return false
        }
    }
}
