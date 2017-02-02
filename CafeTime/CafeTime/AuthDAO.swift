//
//  RealmManager.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/31/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import Foundation
import RealmSwift
import FirebaseDatabase

class AuthDAO {
    
    private let realm = try! Realm()
    
    //    lazy var allNews: Results<NewsItemRealm> = {
    //        self.realm.objects(NewsItemRealm.self)
    //    }()
    
    // MARK: User
    
    func getUserByUid(uid: String) -> UserRealm? {
        return self.realm.object(ofType: UserRealm.self, forPrimaryKey: uid)
    }
    
    func saveUserFromSnapshot(snapshot: FIRDataSnapshot, uid: String) -> UserRealm? {
        
        try! realm.write {
            let user = UserRealm()
            if let firebaseDic = snapshot.value as? [String: AnyObject] {
                user.uid = uid
                user.name = firebaseDic["name"] as? String
                user.email = firebaseDic["email"] as? String
                user.country = firebaseDic["country"] as? String
                realm.add(user, update: true)
            }
        }
        
        return self.getUserByUid(uid: uid)
    }
    
    // MARK: User Credentials
    
    lazy var localUserCredentials : CurrentUserCredentialsRealm? = {
        self.realm.objects(CurrentUserCredentialsRealm.self).first
    }()
    
    func saveCredentials(email: String, password: String) {
        
        self.deleteLocalUserCredentials()
        try! realm.write {
            let localCredentials = CurrentUserCredentialsRealm()
            localCredentials.email = email
            localCredentials.password = password
            realm.add(localCredentials)
        }
    }
    
    func deleteLocalUserCredentials() {
        if let localCredentials = localUserCredentials {
            try! realm.write {
                realm.delete(localCredentials)
            }
        }
    }
    
    // MARK: Clear
    
    func clearRealm() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
