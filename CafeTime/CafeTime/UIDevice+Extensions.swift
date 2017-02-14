//
//  UIDevice+Extensions.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/14/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

import Foundation
//inpired by https://gist.github.com/mortenbekditlevsen/5a0ee16b73a084ba404d

extension UIDevice {
    
    public func MO_isBlurAvailable() -> Bool {
        
        if self.mo_osMajorVersion() < 8 {
            return false
        }
        if UIAccessibilityIsReduceTransparencyEnabled() {
            return false
        }
        if !self.mo_blurSupported() {
            return false
        }
        #if TARGET_IPHONE_SIMULATOR
        #endif
        return true
    }
    
    private func mo_blurSupported () -> Bool {
        let unsupportedDevices = NSSet(objects: "iPad",
                                       "iPad1,1",
                                       "iPhone1,1",
                                       "iPhone1,2",
                                       "iPhone2,1",
                                       "iPhone3,1",
                                       "iPhone3,2",
                                       "iPhone3,3",
                                       "iPod1,1",
                                       "iPod2,1",
                                       "iPod2,2",
                                       "iPod3,1",
                                       "iPod4,1",
                                       "iPad2,1",
                                       "iPad2,2",
                                       "iPad2,3",
                                       "iPad2,4",
                                       "iPad3,1",
                                       "iPad3,2",
                                       "iPad3,3")
        if unsupportedDevices.contains(self.hardwareString()) {
            return false
        } else {
            return true
        }
    }
    // http://stackoverflow.com/a/29997626/979169
    private func hardwareString() -> String {
        var name: [Int32] = [CTL_HW, HW_MACHINE]
        var size: Int = 2
        sysctl(&name, 2, nil, &size, &name, 0)
        var hw_machine = [CChar](repeating: 0, count: Int(size))
        sysctl(&name, 2, &hw_machine, &size, &name, 0)
        let hardware = String(cString: hw_machine)
        return hardware
    }
    private func mo_osMajorVersion() -> Int {
        let vComp: [String] = UIDevice.current.systemVersion.components(separatedBy: ".")
        return Int(vComp.first!)!
    }
    
    
}
