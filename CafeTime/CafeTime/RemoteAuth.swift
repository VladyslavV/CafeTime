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
        return FIRDatabase.database().reference(fromURL: "https://cafetime-6651e.firebaseio.com/").child("Customers")
    }
    
    // MARK: Create
    func createUser(user : User, rememberUser: Bool, completion: @escaping (_ error: String, _ uid: String?) -> Void) {
        
        RemoteUtils.shared.checkUserExists(ref: customersRef, name: user.name, orderBy: "name") { [weak self] (exists) in
            
            guard let weakSelf = self else { return }
            
            if exists {
                completion("User with this name already exists", "")
            }
            else {
                FIRAuth.auth()?.createUser(withEmail: user.email, password: user.password, completion: { (firUser, error) in
                    
                    if let err = error {
                        completion(err.localizedDescription, "")
                        return
                    }
                    print("You have successfully signed up")
                    
                    // save locally
                    if rememberUser {
                        weakSelf.dao.credentials.saveCredentials(email: user.email, password: user.password)
                    }
                    
                    completion("", firUser?.uid)
                })
            }
        }
    }
    
    
    // MARK: Sign In
    
    func authenticateUser(email: String, password: String, rememberUser: Bool, completion: @escaping (_ error: String, _ success: Bool) -> Void) {
        
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
}
