//
//  CafeDAO.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/7/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import RealmSwift
import FirebaseDatabase

class CafeDAO  {

    private let realm = try! Realm()
    
    func getByUid(uid: String) -> CafeRealm? {
        return self.realm.object(ofType: CafeRealm.self, forPrimaryKey: uid)
    }
    
    func saveFromSnapshot(snapshot: FIRDataSnapshot, uid: String) -> CafeRealm? {
        if let firebaseDic = snapshot.value as? [String: AnyObject] {
            try! realm.write {
                let user = CafeRealm()
                user.uid = uid
                user.foodType = firebaseDic["foodType"] as? String
                user.numberOfTables = firebaseDic["numberOfTables"] as? String
                user.profileImageURL = firebaseDic["profileImageURL"] as? String
                user.name = firebaseDic["name"] as? String
                user.email = firebaseDic["email"] as? String
                user.country = firebaseDic["country"] as? String
                realm.add(user, update: true)
            }
        } else {
            self.delete(withUID: uid)
        }
        return self.getByUid(uid: uid)
    }
    
    func delete(withUID uid: String) {
        ManagerDAO.access.credentials.deleteLocalUserCredentials()
        if let userToDelete = self.getByUid(uid: uid) {
            try! realm.write {
                self.realm.delete(userToDelete)
            }
        }
    }
    
    func printStoredUsers() {
        print(realm.objects(CafeRealm.self))
    }
    
}
