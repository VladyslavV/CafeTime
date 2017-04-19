//
//  Slider.swift
//  CircleSlider
//
//  Created by Vladyslav Vyshnevksyy on 4/16/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class Slider: UIView {

    let smallLineWith: CGFloat = 1
    let smallLineOffset: CGFloat = 3

    override func draw(_ rect: CGRect) {

        let pathTotal = UIBezierPath(arcCenter: CGPoint(x: rect.width/2, y: rect.height/2),
                                     radius: rect.width / 2 ,
                                     startAngle: 0,
                                     endAngle: 360,
                                     clockwise: true)
        
        UIColor.white.setFill()
        pathTotal.fill()
        
        let line = UIBezierPath(arcCenter: CGPoint(x: rect.width/2, y: rect.height/2),
                                     radius: rect.width / 2 - smallLineOffset,
                                     startAngle: 0,
                                     endAngle: 360,
                                     clockwise: true)
        
        UIColor.green.setStroke()
        line.lineWidth = smallLineWith
        line.stroke()
        
    }
    
    
}
