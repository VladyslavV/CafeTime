
//
//  Color.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 3/18/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

struct Colors {
    
    // General
    static let black = UIColor.black
    
    static let primaryGray = Colors.prepareColorWith(red: 241.0, green: 241.0, blue: 241.0, alpha: 1)
    
    static let primaryGreen = Colors.prepareColorWith(red: 70, green: 208, blue: 0, alpha: 1)

    static let darkYellow = Colors.prepareColorWith(red: 254, green: 192, blue: 9, alpha: 1)
    
    
    static let clear = UIColor.clear

    
    // Nav Bar
    struct NavBar {
        
        static let green = UIColor.green

    }
    
    static func prepareColorWith(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return  UIColor.init(red: red/255.0,
                             green: green/255.0,
                             blue: blue/255.0,
                             alpha: 1)
    }

}
