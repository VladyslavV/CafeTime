//
//  Circle.swift
//  CircleSlider
//
//  Created by Vladyslav Vyshnevksyy on 4/16/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}


import UIKit

class Circle: UIView {

    
    let bigLineWidth: CGFloat = 20
    let smallLineWith: CGFloat = 4

    var totalLineWidth: CGFloat {
        return bigLineWidth + smallLineWith * 2
    }
    

    override func draw(_ rect: CGRect) {
    
        let pathInBetween = self.createCirclePathwithRadius(rect.width / 2 - bigLineWidth / 2 - smallLineWith, forRect: rect)

        let context = UIGraphicsGetCurrentContext()

        context!.beginTransparencyLayer (auxiliaryInfo: nil)
        UIColor.blue.setStroke()
        pathInBetween.lineWidth = bigLineWidth
        pathInBetween.stroke()
        context!.setBlendMode(.sourceIn)
        
        let colors          = [UIColor.green.cgColor, UIColor.yellow.cgColor]
        let colorSpace      = CGColorSpaceCreateDeviceRGB()
        let colorLocations  :[CGFloat] = [0.0, 1.0]
        let gradient        = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations)
        let startPoint      = CGPoint(x: rect.size.width/2, y: 0)
        let endPoint        = CGPoint(x: rect.size.width/2, y: rect.size.height)
        
        context!.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        context!.endTransparencyLayer()
        
        let pathInner = self.createCirclePathwithRadius(rect.width / 2 - bigLineWidth - smallLineWith - smallLineWith / 2, forRect: rect)
        
        UIColor.green.setStroke()
        pathInner.lineWidth = smallLineWith
        pathInner.stroke()
        
        let pathOutter = self.createCirclePathwithRadius(rect.width / 2 - smallLineWith / 2, forRect: rect)
      
        UIColor.green.setStroke()
        pathOutter.lineWidth = smallLineWith
        pathOutter.stroke()
        
        self.createSmallCircles(rect)
    }

    func createCirclePathwithRadius(_ radius: CGFloat, forRect  rect: CGRect) -> UIBezierPath {
        
        return UIBezierPath(arcCenter: CGPoint(x: rect.width/2, y: rect.height/2),
                                      radius: radius,
                                      startAngle: CGFloat(0.degreesToRadians),
                                      endAngle: CGFloat(360.degreesToRadians),
                                      clockwise: true)
        
        
    }
    
    func createSmallCircles(_ rect: CGRect) {
        for i in 0..<12 {
            
            let startAngle = CGFloat(i) * 360 / 12
            let endAngle = CGFloat(i) * 360 / 12 + 1
            let pathInner = UIBezierPath(arcCenter:
                CGPoint(x: rect.width/2, y: rect.height/2),
                                         radius: rect.width / 2 - bigLineWidth - smallLineWith - smallLineWith / 2 - smallLineWith * 2,
                                         startAngle: startAngle.degreesToRadians,
                                         endAngle: endAngle.degreesToRadians,
                                         clockwise: true)
            
            UIColor.green.setStroke()
            pathInner.lineWidth = 2
            pathInner.stroke()
        }
    }
}
