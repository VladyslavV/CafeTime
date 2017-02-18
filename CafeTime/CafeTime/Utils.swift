//
//  Utils.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/2/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SwiftCop

class Utils: NSObject {

    static let shared = Utils()
    
    private override init() { }
    
    // numbers
    func isNumberString(string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
    }
    
    // email
    func isValidEmail(email: String) -> Bool {
        let emailTrial = Trial.email
        let validEmail = emailTrial.trial()
        
        if !validEmail(email) {
            return  false
        }
        return true
    }

    
    // compress image to jpeg and return data
    
    func imageToJpegCompressed(image: UIImage?) -> Data? {
        if let newImage = image, let imageData = UIImageJPEGRepresentation(newImage, 0.1) {
            return imageData
        }
        return nil
    }
    
    // turn properties into dict
    func getDictFromUser(user: User) -> [String : AnyObject] {
        
        var dict = [String : AnyObject]()
        let mirroredObject = Mirror(reflecting: user)
        let superMirroredObject = mirroredObject.superclassMirror
        
        for (_, attr) in mirroredObject.children.enumerated() {
            if let propertyName = attr.label as String! {
                dict[propertyName] = attr.value as AnyObject?
            }
        }
        
        for (_, attr) in (superMirroredObject?.children.enumerated())! {
            if let property_name = attr.label as String! {
                dict[property_name] = attr.value as AnyObject?
            }
        }
        return dict
    }
    
    func isBlurEnabled() -> Bool {
        let device = UIDevice()
        if  device.MO_isBlurAvailable() {
            return true
        }
        return false
    }
    
    func screenSize() -> CGSize {
        return UIScreen.main.bounds.size
    }

}
