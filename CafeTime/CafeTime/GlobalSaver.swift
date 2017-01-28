//
//  GlobalSaver.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/27/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class GlobalSaver {
    
    static let shared = GlobalSaver()
    
    func saveUser(email: String, password: String) {
        KeychainWrapper.standard.set(email, forKey: Globals.savedEmail)
        KeychainWrapper.standard.set(password, forKey: Globals.savedPassword)
    }
    
    func getUserCredentials() -> (email : String?, password: String?) {
        let email = KeychainWrapper.standard.string(forKey: Globals.savedEmail)
        let password = KeychainWrapper.standard.string(forKey: Globals.savedPassword)
        return (email, password)
    }
    
    func clearUser() {
        KeychainWrapper.standard.removeObject(forKey: Globals.savedEmail)
        KeychainWrapper.standard.removeObject(forKey: Globals.savedPassword)
    }
    
}
