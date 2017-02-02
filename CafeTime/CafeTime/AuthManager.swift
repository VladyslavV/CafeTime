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
    
    private let storageRef = FIRStorage.storage().reference()
    
    private var dataBaseRef : FIRDatabaseReference {
        return FIRDatabase.database().reference(fromURL: "https://cafetime-6651e.firebaseio.com/")
    }
    
    private var usersRef : FIRDatabaseReference { return self.dataBaseRef.child("Customers")     }
    
    private var cafesRef : FIRDatabaseReference { return self.dataBaseRef.child("Cafes") }
    
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
    
    // MARK: Create and save user
    func createUser(user : User, rememberUser: Bool, completion: @escaping (_ error: String, _ success: Bool) -> Void) {
        
        FIRAuth.auth()?.createUser(withEmail: user.email, password: user.password, completion: { [weak self] (firUser, error) in
            
            guard let weakSelf = self else { return }
            
            if let err = error {
                completion(err.localizedDescription, false)
                return
            }
            print("You have successfully signed up")
            
            // save locally
            if rememberUser {
                let dao = AuthDAO()
                dao.saveCredentials(email: user.email, password: user.password)
            }
            
            // save on the server
            if let uid = firUser?.uid {
                weakSelf.saveUserToFirebase(user: user, uid: uid, completion: { (success) in
                    if success {
                        completion("", true)
                    }
                    else {
                        completion("Could not saved user to the Database", false)
                    }
                })
            }
        })
    }
    
    private func saveUserToFirebase(user: User, uid: String ,completion: @escaping (Bool) -> Void) {
        
        var userReference: FIRDatabaseReference?
        var values: [AnyHashable : Any]?
        
        if user.isKind(of: Cafe.self) {
            if let cafe = user as? Cafe {
                userReference = dataBaseRef.child("Cafe").child(uid)
                values = ["name" : cafe.name, "country" : cafe.country, "email" : cafe.email, "numberOfTables" : cafe.numberOfTables,
                          "foodTpye" : cafe.foodtype]
            }
        }
        else {
            userReference = dataBaseRef.child("Customers").child(uid)
            values = ["name" : user.name, "country" : user.country, "email" : user.email]
        }
        
        if let val = values, let ref = userReference {
            ref.updateChildValues(val) { (error, ref) in
                if let err = error {
                    print(err)
                    completion(false)
                    return
                }
                completion(true)
                print("Successflully saved customer to the Firebase db")
            }
        }
    }
    
    
    // MARK: User
    
    func userCredentials() -> CurrentUserCredentialsRealm? {
        return AuthDAO().localUserCredentials
    }
    
    
    func logOutUser() {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                let dao = AuthDAO()
                dao.deleteLocalUserCredentials()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    
    func getCurrentUser(completion: @escaping (UserRealm?) -> Void) {
        
        if let user = FIRAuth.auth()?.currentUser {
            
            if let existingUser = dao.getUserByUid(uid: user.uid) {
                completion(existingUser)
            }
            
            currentUserObserver = usersRef.child(user.uid).observe(.value , with: { [weak self] (snapshot) in
                guard let weakSelf = self else { return }
                if snapshot.exists() {
                    completion(weakSelf.dao.saveUserFromSnapshot(snapshot: snapshot, uid: user.uid))
                }
                
            })
        }
    }
    
    func removeUserObserver() {
        if let obs = currentUserObserver {
            usersRef.removeObserver(withHandle: obs)
        }
    }
 }
