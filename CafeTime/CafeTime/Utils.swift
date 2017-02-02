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
}