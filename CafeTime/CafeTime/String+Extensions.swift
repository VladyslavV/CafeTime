//
//  File.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/17/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//


extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSFontAttributeName: font]
        let size = self.size(attributes: fontAttributes)
        return size.height
    }
}
