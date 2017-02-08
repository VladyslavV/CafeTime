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
    
    // login credentials details
    func checkLoginDetails(email : String, password: String) -> String? {
        
        var errorString = self.checkEmptyFieldsForUser(fields: [email, password])
        
        if let err = errorString  { return err }
        
        errorString = self.checkBasicCredentials(email: email, password: password)
        
        if let err = errorString  { return err }
        
        return nil
    }
    
    // sign up details
    func checkSignUpFieldsForUser(user: User) -> String? {
        
        var errorString = self.checkEmptyFieldsForUser(fields: user.requiredFields )
        if let err = errorString  { return err }
    
        errorString = checkBasicCredentials(email: user.email, password: user.password)
        if let err = errorString  { return err }
        
        errorString = self.checkUserName(name: user.name)
        if let err = errorString  { return err }
        
        if user.isKind(of: Cafe.self) {
            if let cafe = user as? Cafe {
                errorString = self.checkNumberOfTables(number: cafe.numberOfTables)
                if let err = errorString  { return err }
            }
        }
        return nil
    }
    
    // MARK: Private Funcs
    
    private func checkBasicCredentials(email: String, password: String) -> String? {
        
        if !Utils.shared.isValidEmail(email: email) { return "Invalid Email" }
        
        let errorString = self.checkPassword(email: email, password: password)
        
        if let err = errorString  { return err }
        
        return nil
    }
    
    private func checkNumberOfTables(number: String) -> String? {
        
        if let num = Int(number) {
            if num < 1 || num > 1000 { return "Invalid number of tables" }
        }
        else {
            return "Invalid number of tables"
        }
        return nil
    }
    
    //password
    private func checkPassword(email: String, password: String) -> String? {
        
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
        
        return nil
    }
    
    // empty fields
    private func checkEmptyFieldsForUser(fields: [String]) -> String? {
        for field in fields {
            if field.isEmpty {
                return "Required fields cannot be empty"
            }
        }
        return nil
    }
    
    private func checkUserName(name: String) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: "^[0-9a-zA-Z\\_]{2,18}$", options: .caseInsensitive)
            if regex.matches(in: name, options: [], range: NSMakeRange(0, name.characters.count)).count > 0 {
                return nil
            }
        }
        catch {}
        return "Invalid Name\n"
    }
}
