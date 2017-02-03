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
        
        if let firebaseDic = snapshot.value as? [String: AnyObject] {
            try! realm.write {
                let user = UserRealm()
                user.uid = uid
                user.profileImageURL = firebaseDic["profileImageURL"] as? String
                user.name = firebaseDic["name"] as? String
                user.email = firebaseDic["email"] as? String
                user.country = firebaseDic["country"] as? String
                realm.add(user, update: true)
            }
        } else {
            self.deleteUser(withUID: uid)
        }
        return self.getUserByUid(uid: uid)
    }
    
    
    func deleteUser(withUID uid: String) {
        self.deleteLocalUserCredentials()
        if let userToDelete = realm.object(ofType: UserRealm.self, forPrimaryKey: uid) {
            try! realm.write {
                realm.delete(userToDelete)
            }
        }
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
