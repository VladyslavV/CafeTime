//
//  RealmManager.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/31/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManager {
    
    private let realm = try! Realm()
    
    //    lazy var allNews: Results<NewsItemRealm> = {
    //        self.realm.objects(NewsItemRealm.self)
    //    }()
    
    // MARK: User
    lazy var localUser : UserRealm? = {
        self.realm.objects(UserRealm.self).first
    }()
    
    func saveUser(user: User) {
        try! realm.write {
            let userRealm = UserRealm()
            userRealm.name = user.name
            userRealm.email = user.email
            userRealm.country = user.country
            userRealm.uid = user.uid
            realm.add(userRealm, update: true)
        }
    }
    
   // MARK: User Credentials
    lazy var localUserCredentials : CurrentUserCredentialsRealm? = {
        self.realm.objects(CurrentUserCredentialsRealm.self).first
    }()
    
    func saveCredentials(email: String, password: String) {
        self.clearLocalUserCredentials()
        try! realm.write {
            let localCredentials = CurrentUserCredentialsRealm()
            localCredentials.email = email
            localCredentials.password = password
            realm.add(localCredentials)
        }
    }
    
    // MARK: Clear
    
    func clearRealm() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func clearLocalUserCredentials() {
        if let localCredentials = localUserCredentials {
            try! realm.write {
                realm.delete(localCredentials)
            }
        }
    }
}
