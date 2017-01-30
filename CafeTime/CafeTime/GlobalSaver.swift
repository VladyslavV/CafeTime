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
    
    func saveLocalUserCredentials(email: String, password: String) {
        KeychainWrapper.standard.set(email, forKey: GlobalStrings.savedEmail)
        KeychainWrapper.standard.set(password, forKey: GlobalStrings.savedPassword)
    }
    
    func getLocalUserCredentials() -> (email : String?, password: String?) {
        let email = KeychainWrapper.standard.string(forKey: GlobalStrings.savedEmail)
        let password = KeychainWrapper.standard.string(forKey: GlobalStrings.savedPassword)
        return (email, password)
    }
    
    func clearUser() {
        KeychainWrapper.standard.removeObject(forKey: GlobalStrings.savedEmail)
        KeychainWrapper.standard.removeObject(forKey: GlobalStrings.savedPassword)
    }
}
