//
//  StringsChecker.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/29/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import SwiftCop

class StringsChecker {
    
    static let shared = StringsChecker()
    
    // MARK: Pulic Funcs
    
    // login details
    func checkLoginDetails(email : String, password: String) -> String {
        
        var errorString = self.checkEmptyStrings(strings: [email, password])
        
        if errorString != "" { return errorString }
        
        errorString = self.checkBasicCredentials(email: email, password: password)
        
        if errorString != "" { return errorString }
        
        return ""
    }
    
    // sign up details
 
    
    func checkCommonDetails(email: String, name: String, password: String) -> String {
        
        var errorString = self.checkEmptyStrings(strings: [email, password, name])
        
        if errorString != "" { return errorString }
        
        errorString  = self.checkBasicCredentials(email: email, password: password)
        
        if errorString != "" { return errorString }
        
        errorString = self.checkUserName(name: name)
        
        if errorString != "" { return errorString }

        return ""
    }
    
    func checkCafeAdditionalDetails(numberOfTables: String) -> String {
        
        let errorString = self.checkNumberOfTables(number: numberOfTables)
        
        if errorString != "" { return errorString }
        
        return ""
    }
    
    
    // MARK: Private Funcs
    
    private func checkBasicCredentials(email: String, password: String) -> String {
        
        var errorString = self.checkEmptyStrings(strings: [email, password])
        
        errorString = self.checkEmail(email: email)
        
        if errorString != "" { return errorString }
        
        errorString = self.checkPassword(email: email, password: password)
        
        if errorString != "" { return errorString }
        
        return ""
    }
    
    private func checkNumberOfTables(number: String) -> String {
        
        if let num = Int(number) {
            if num < 1 || num > 1000 { return "Invalid number of tables" }
        }
        else {
            return "Invalid number of tables"
        }
        
        
        return ""
    }
    
    private func checkEmail(email: String) -> String {
        let emailTrial = Trial.email
        let validEmail = emailTrial.trial()
        
        if !validEmail(email) {
            return  "Invalid email\n"
        }
        return ""
    }
    
    private func checkEmptyStrings(strings: [String]) -> String {
        for string in strings {
            if string == "" {
                return "Required fields cannot be empty"
            }
        }
        return ""
    }
    
    
    private func checkPassword(email: String, password: String) -> String{
        
        let lengthTrial = Trial.length(.minimum, 6)
        let longEnough = lengthTrial.trial()
        
        let passwordMatchesEmailTrial = Trial.inclusion([email])
        let passwordMatchesEmail = passwordMatchesEmailTrial.trial()
        
        let passwordContainsSpacesTrial = Trial.inclusion([" "])
        let passwordContainsSpaces = passwordContainsSpacesTrial.trial()
        
        if !longEnough(password)  {
            return "Password should be at least 6 characters long\n"
        }
        
        if passwordMatchesEmail(password) {
            return "Password should not match email\n"
        }
        
        if passwordContainsSpaces(password) {
            return "Password should not contain spaces"
        }
        
        return ""
    }
    
    func checkUserName(name: String) -> String {
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9a-zA-Z\\_]{2,18}$", options: .caseInsensitive)
            if regex.matches(in: name, options: [], range: NSMakeRange(0, name.characters.count)).count > 0 {
                return ""
            }
        }
        catch {}
        return "Invalid user name"
    }
    
    
}
