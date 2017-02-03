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
 import FirebaseDatabase
 import FirebaseStorage
 
 
 class AuthManager {
    
    // MARK: Private
    
    static let shared = AuthManager()
    private init() { }
    
    private let dao = AuthDAO()
    
    internal let storageRef = FIRStorage.storage().reference()
    
    private var dataBaseRef : FIRDatabaseReference {
        return FIRDatabase.database().reference(fromURL: "https://cafetime-6651e.firebaseio.com/")
    }
    
    internal var customersRef : FIRDatabaseReference { return self.dataBaseRef.child("Customers") }
    internal var cafesRef : FIRDatabaseReference { return self.dataBaseRef.child("Cafes") }
    
    internal var dataBaseStorageRef = FIRStorage.storage().reference(forURL: "gs://cafetime-6651e.appspot.com/")
    
    private var currentUserObserver: FIRDatabaseHandle?
    
    // MARK: Public
    
    func authenticateUser(email: String, password: String, rememberUser: Bool, completion: @escaping (_ error: String, _ success: Bool) -> Void) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            
            if let err = error {
                completion((err.localizedDescription), false)
                return
            }
            
            print("You have successfully logged in")
            
            
            if rememberUser {
                let dao = AuthDAO()
                dao.saveCredentials(email: email, password: password)
            }
            
            completion("", true)
        }
    }
    
    // MARK: User
    
    func userCredentials() -> CurrentUserCredentialsRealm? {
        return AuthDAO().localUserCredentials
    }
    
    
    func logOutUser() {
        if let auth = FIRAuth.auth() {
            do {
                try auth.signOut()
                let dao = AuthDAO()
                dao.deleteLocalUserCredentials()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    func observeCurrentUser(completion: @escaping (UserRealm?) -> Void) {
        
        if let user = FIRAuth.auth()?.currentUser {
            
            if let existingUser = dao.getUserByUid(uid: user.uid) {
                completion(existingUser)
            }
            
            currentUserObserver = customersRef.child(user.uid).observe(.value , with: { [weak self] (snapshot) in
            
                guard let weakSelf = self else { return }
                
                if snapshot.key == user.uid {
                    completion(weakSelf.dao.saveUserFromSnapshot(snapshot: snapshot, uid: user.uid))
                }
                else {
                    weakSelf.dao.deleteUser(withUID: user.uid)
                }
            })
        }
    }
    
    func removeUserObserver() {
        if let obs = currentUserObserver {
            customersRef.removeObserver(withHandle: obs)
        }
    }
    
 }
