//
//  RemoteAuth.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/7/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RemoteAuth {
    
    private let dao = ManagerDAO.access
    private var customersRef: FIRDatabaseReference {
        return FIRDatabase.database().reference().child(Constants.Remote.References.Customers)
    }
    private var cafesRef: FIRDatabaseReference {
        return FIRDatabase.database().reference().child(Constants.Remote.References.Cafes)
    }
    
    // MARK: Create
    func createUser(user : User, rememberUser: Bool, completion: @escaping (_ error: String?, _ uid: String?) -> Void) {
        
        let validator = Validator.shared

        let errorString = validator.checkSignUpFieldsForUser(user: user)
        
        if let err = errorString {
            completion(err,nil)
            return
        }
        
        RemoteUtils.shared.checkUserExists(ref: customersRef, name: user.name, orderBy: "name") { [weak self] (error) in
            
            guard let weakSelf = self else { return }
            
            if let err = error {
                completion(err, "")
            }
                
            else {
                FIRAuth.auth()?.createUser(withEmail: user.email, password: user.password, completion: { (firUser, error) in
                    
                    if let err = error {
                        completion(err.localizedDescription, nil)
                        return
                    }
                    print("You have successfully signed up")
                    
                    // save locally
                    if rememberUser {
                        weakSelf.dao.credentials.saveCredentials(email: user.email, password: user.password)
                    }
                    
                    completion(nil, firUser?.uid)
                })
            }
        }
    }
    
    // MARK: Sign In
    
    func authenticateUser(email: String, password: String, rememberUser: Bool, completion: @escaping (_ error: String, _ success: Bool) -> Void) {
        
        let validator = Validator.shared
        
        let errorString = validator.checkLoginDetails(email: email, password: password)
        
        if let error = errorString {
            completion(error,false)
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            
            if let err = error {
                completion((err.localizedDescription), false)
                return
            }
            
            print("You have successfully logged in")
            
            
            if rememberUser {
                let dao = ManagerDAO.access
                dao.credentials.saveCredentials(email: email, password: password)
            }
            
            completion("", true)
        }
    }
    
    // MARK: Sign Out
    func logOutUser() {
        if let auth = FIRAuth.auth() {
            do {
                try auth.signOut()
                dao.credentials.deleteLocalUserCredentials()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: Get Credentials
    func userCredentials() -> CurrentUserCredentialsRealm? {
        return dao.credentials.getLocalUserCredentials()
    }
    
    // MARK: Check if local user
    func isLocalUser(withUID uid: String) -> Bool {
        
        if let currentUser = FIRAuth.auth()?.currentUser {
            if uid == currentUser.uid {
                return true
            }
        }
        
        return false
    }
    
    
    // MARK: Delete User
    
    // delete self ... need to relogin
    func deleteCurrentUser(customer:Bool, completion: @escaping (String,Bool) -> () ) {
        
        if let currentUser = FIRAuth.auth()?.currentUser {
            
            //delete from Realm
            
            var reference: FIRDatabaseReference?
            if customer {
                ManagerDAO.access.customer.delete(withUID: currentUser.uid)
                reference = self.customersRef.child(currentUser.uid)
                
            }
            else {
                ManagerDAO.access.cafe.delete(withUID: currentUser.uid)
                reference = self.cafesRef.child(currentUser.uid)
            }
            
            if let ref = reference {
                RemoteUtils.shared.deleteNodeFromFirebaseWithReference(ref: ref, completion: { (success) in
                    
                    if !success {
                        completion("Couldn't delete users data", false)
                        return
                    }
                    
                    // auth sensitive --- requires recent login
                    currentUser.delete(completion: { (error) in
                        
                        if let err = error {
                            print(err.localizedDescription)
                            completion(err.localizedDescription, false)
                            return
                        }
                        
                        completion("", true)
                    })
                })
            }
        }
    }
}
