//
//  CircleTimeSlider.swift
//  CircleSlider
//
//  Created by Vladyslav Vyshnevksyy on 4/17/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class CircleTimeSlider: UIView {

    
    // MARK: Init
    
    override init(frame: CGRect) {
        
        circle = Circle(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        
        super.init(frame: frame)
        
        self.isUserInteractionEnabled = true
        
        self.addSubview(circle)
        circle.backgroundColor = UIColor.white
        
        circle.addSubview(slider)
        slider.backgroundColor = UIColor.clear
        slider.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_ :))))
        
        circle.addSubview(timeLabel)
        
        placeSliderAtAngle(0)
        adjustTimeToAngle(0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Vars
    
    let circle: Circle
    
    lazy var slider: Slider = {
        let myVar = Slider(frame: CGRect(x: 0, y: 0, width: self.circle.totalLineWidth + 20, height: self.circle.totalLineWidth + 20))
        myVar.isUserInteractionEnabled = true
        return myVar
    }()
    
    lazy var timeLabel: UILabel = {
        let myVar = UILabel()
        myVar.text = "8:15"
        myVar.font = UIFont.boldSystemFont(ofSize: 40)
        myVar.textAlignment = NSTextAlignment.center
        myVar.frame = CGRect(x: 0, y: 0, width: self.circle.frame.width, height: self.circle.frame.width)
        myVar.center = CGPoint(x: self.circle.frame.width/2, y: self.circle.frame.height/2)
        myVar.isUserInteractionEnabled = false
        return myVar
    }()
    
    
    // MARK: Set Up
    
    func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: circle);
        let y = location.y - circle.frame.height/2;
        let x = location.x - circle.frame.width/2;
        
        var radians = atan(y/x)
        if x < 0 {
            radians += CGFloat(M_PI)
        }
        
        placeSliderAtAngle(radians)
        adjustTimeToAngle(radians)
    }
    
    func placeSliderAtAngle(_ angle: CGFloat) {
        slider.center.x = circle.frame.width/2 + (circle.frame.width / 2 - circle.bigLineWidth / 2 - circle.smallLineWith) * cos(angle)
        slider.center.y = circle.frame.height/2 + (circle.frame.height / 2 -  circle.bigLineWidth / 2 - circle.smallLineWith) * sin(angle)
    }
    
    var additionalHours = 0
    var globalHours = 0
    var prevAngle = 0.0
    var lap = 0
    
    func adjustTimeToAngle(_ angle: CGFloat) {
        
        let hours = angle.radiansToDegrees * 2 / 60 + 3
        var minutes = Int(angle.radiansToDegrees * 2) % 60
        
        if minutes < 0 {
            minutes += 60
        }
        
        if  abs(angle.radiansToDegrees) > 50  {
            
            if prevAngle > 0  && angle.radiansToDegrees < 0 {
                lap = 1
                
                if globalHours > 22 {
                    lap = 0
                }
            }
            
            if prevAngle < 0  && angle.radiansToDegrees > 0 {
                lap = 0
                
                if globalHours < 3 {
                    lap = 1
                }
            }
        }
        
        
        if lap == 1 {
            additionalHours = 12
        }
        else {
            additionalHours = 0
        }
        
        globalHours = Int(hours) + additionalHours
        self.timeLabel.text = "\(globalHours < 10 ? "0" : "")\(globalHours):\(minutes < 10 ? "0" : "")\(Int(minutes))"
        prevAngle = Double(angle.degreesToRadians)
    }

}
