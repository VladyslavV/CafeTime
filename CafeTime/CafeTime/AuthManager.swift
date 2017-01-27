//
//  AuthLogicShared.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/26/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import Foundation
import Firebase
import SwiftCop

class AuthManager {
    static let shared = AuthManager()
    
    func authenticateUser(email: String, password: String, rememberUser: Bool, completion: @escaping (_ error: String, _ success: Bool) -> Void) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                completion((error?.localizedDescription)!, false)
                return
            }
            
            print("You have successfully logged in")
            
            if rememberUser {
                GlobalSaver.shared.saveUser(email: email, password: password)
            }
            
            completion("", true)
        }
    }

    func createUser(email: String, password: String, rememberUser: Bool, completion: @escaping (_ error: String, _ success: Bool) -> Void)  {
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                completion((error?.localizedDescription)!, false)
                return
            }
            
            print("You have successfully signed up")
            
            if rememberUser {
                GlobalSaver.shared.saveUser(email: email, password: password)
            }
            
            completion("", true)
        })
    }
    
    
    func logOutUser() {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        GlobalSaver.shared.clearUser()
    }
    
 
    func checkEmail(email : String, andPassword password: String) -> String {
        
        let emailTrial = Trial.email
        let validEmail = emailTrial.trial()
        
        let lengthTrial = Trial.length(.minimum, 6)
        let longEnough = lengthTrial.trial()
        
        let inclusionTrial = Trial.inclusion([email])
        let passwordMatchesEmail = inclusionTrial.trial()
        
        if email == "" {
            return "Email cannot be empty\n"
        }
        
        if !validEmail(email) {
            return  "Invalid email\n"
        }
        
        if password == "" {
            return "Password field cannot be empty\n"
        }
        
        if !longEnough(password)  {
            return "Password should be at least 6 characters long\n"
        }
        
        if passwordMatchesEmail(password) {
            return "Password should not match email\n"
        }
        return ""
    }
   
    //    func logOutIfNeeded() {
    //        // log out if not authenticated
    //        print(FIRAuth.auth()?.currentUser?.uid ?? "");
    //        if FIRAuth.auth()?.currentUser?.uid == nil {
    //            self.logOutUser()
    //        }
    //    }
    
    
}
