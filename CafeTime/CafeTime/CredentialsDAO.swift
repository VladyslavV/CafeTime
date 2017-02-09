//
//  CredentialsDAO.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/7/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import RealmSwift

class CredentialsDAO {

    private let realm = try! Realm()
    // MARK: User Credentials
    
    func saveCredentials(email: String, password: String) {
        self.deleteLocalUserCredentials()
        try! realm.write {
            let localCredentials = CurrentUserCredentialsRealm()
            localCredentials.email = email
            localCredentials.password = password
            realm.add(localCredentials)
        }
    }
    
    func getLocalUserCredentials() -> CurrentUserCredentialsRealm?  {
        return self.realm.objects(CurrentUserCredentialsRealm.self).first
    }
    
    
    func deleteLocalUserCredentials() {
        if let localCredentials = getLocalUserCredentials() {
            try! realm.write {
                realm.delete(localCredentials)
            }
        }
    }
    
}
