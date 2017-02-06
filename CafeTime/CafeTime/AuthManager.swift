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
    
    private init() {
        self .setUpStateListener()
    }
    
    internal let dao = DAO()
    
    internal let storageRef = FIRStorage.storage().reference()
    
    private var dataBaseRef : FIRDatabaseReference {
        return FIRDatabase.database().reference(fromURL: "https://cafetime-6651e.firebaseio.com/")
    }
    
    internal var customersRef : FIRDatabaseReference { return self.dataBaseRef.child("Customers") }
    internal var cafesRef : FIRDatabaseReference { return self.dataBaseRef.child("Cafes") }
    internal var dataBaseStorageRef = FIRStorage.storage().reference(forURL: "gs://cafetime-6651e.appspot.com/")
    
    private var stateListener: FIRAuthStateDidChangeListenerHandle?
    
    internal var connectionStateListener: FIRDatabaseHandle?
    internal var connectedRef: FIRDatabaseReference?
    internal var isUserConnected = false
    internal var isFirebaseConnectionActive = false
    
    private func setUpStateListener() {
        
        connectedRef = FIRDatabase.database().reference(withPath: ".info/connected")
        connectionStateListener = connectedRef?.observe(.value, with: { [weak self] snapshot in
            guard let weakSelf = self else { return }
            if let connected = snapshot.value as? Bool, connected {
                weakSelf.isFirebaseConnectionActive = true
                print("Connected to server")
            } else {
                weakSelf.isFirebaseConnectionActive = false
                print("Not connected to server")
            }
        })
        
        
        //        stateListener = FIRAuth.auth()?.addStateDidChangeListener({ [weak self] (auth, firUser) in
        //            guard let weakSelf = self else { return }
        //            if let user = firUser {
        //                print("connected")
        //                weakSelf.isUserConnected = true
        //            }
        //            else {
        //                print("no connection")
        //                weakSelf.isUserConnected = false
        //            }
        //        })
    }
    
    deinit {
        
        if let ref = connectedRef, let listener = connectionStateListener {
            ref.removeObserver(withHandle: listener)
        }
        
        if let listener = stateListener {
            FIRAuth.auth()?.removeStateDidChangeListener(listener)
        }
    }
    
    // MARK: Public
    
    func authenticateUser(email: String, password: String, rememberUser: Bool, completion: @escaping (_ error: String, _ success: Bool) -> Void) {
        
        if !isFirebaseConnectionActive {
            completion("No connection", false)
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            
            if let err = error {
                completion((err.localizedDescription), false)
                return
            }
            
            print("You have successfully logged in")
            
            
            if rememberUser {
                let dao = DAO()
                dao.saveCredentials(email: email, password: password)
            }
            
            completion("", true)
        }
    }
    
    // MARK: User
    
    func userCredentials() -> CurrentUserCredentialsRealm? {
        return DAO().getLocalUserCredentials()
    }
    
    func logOutUser() {
        if let auth = FIRAuth.auth() {
            do {
                try auth.signOut()
                let dao = DAO()
                dao.deleteLocalUserCredentials()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Sign up for updates on the user info
    
    func observeCurrentUser(completion: @escaping (UserRealm?) -> Void) {
        
        if let user = FIRAuth.auth()?.currentUser {
            
            if let existingUser = dao.getUserByUid(uid: user.uid) {
                completion(existingUser)
            }
            
            customersRef.child(user.uid).observeSingleEvent(of: .value , with: { [weak self] (snapshot) in
                
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
    
    
 }
