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
    
    static let shared : AuthManager =  {
        let instance = AuthManager()
        return instance
    }()
    
    
    private let storageRef = FIRStorage.storage().reference()
    
    private lazy var dataBaseRef : FIRDatabaseReference = {
        let ref = FIRDatabase.database().reference(fromURL: "https://cafetime-6651e.firebaseio.com/")
        return ref
    }()
    
    private lazy var usersRef : FIRDatabaseReference = {
        let ref = self.dataBaseRef.child("Customers")
        return ref
    }()
    
    private lazy var cafesRef : FIRDatabaseReference = {
        let ref = self.dataBaseRef.child("Cafes")
        return ref
    }()
    
    private let currentUser = FIRAuth.auth()?.currentUser
    
    
    // MARK: Public
    
    func authenticateUser(email: String, password: String, rememberUser: Bool, completion: @escaping (_ error: String, _ success: Bool) -> Void) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                completion((error?.localizedDescription)!, false)
                return
            }
            
            print("You have successfully logged in")
            
            if rememberUser {
                GlobalSaver.shared.saveLocalUserCredentials(email: email, password: password)
            }
            
            completion("", true)
        }
    }
    
    func createUser(email: String, name: String, numberOfTables: String, country: String, foodType: String, password: String, rememberUser: Bool, completion: @escaping (_ error: String, _ success: Bool) -> Void)  {
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { [weak self] (user, error) in
            
            guard let weakSelf = self else { return }
            
            if error != nil {
                completion((error?.localizedDescription)!, false)
                return
            }
            print("You have successfully signed up")
            
            if rememberUser {
                GlobalSaver.shared.saveLocalUserCredentials(email: email, password: password)
            }
            
            weakSelf.saveUserToFirebase(user: user, email: email, name: name, country: country, foodType: foodType, numberOfTables: numberOfTables, completion: { success in
                if success {
                    completion("", true)
                }
                else {
                    completion("Could not saved user to the Database", false)
                }
            })
        })
    }
    
    // MARK: Save the user to the server database
    
    private func saveUserToFirebase(user: FIRUser?, email: String, name:String, country:String, foodType: String, numberOfTables: String, completion: @escaping (Bool) -> Void) {
        
        guard let uid = user?.uid else { return }
        
        //case cafe
        if Int(numberOfTables)! > 0 {
            let userReference = dataBaseRef.child("Cafes").child(uid)
            let values = ["name" : name, "country" :country, "email" : email, "numberOfTables" : numberOfTables, "foof type" : foodType]
            userReference.updateChildValues(values) { (err, ref) in
                
                if err != nil {
                    print(err!)
                    completion(false)
                    return
                }
                
                completion(true)
                print("Successflully saved cafe to the Firebase db")
            }
        }
        else {
            let userReference = dataBaseRef.child("Customers").child(uid)
            let values = ["name" : name, "country" :country, "email" : email]
            userReference.updateChildValues(values) { (err, ref) in
                
                if err != nil {
                    print(err!)
                    completion(false)
                    return
                }
                
                completion(true)
                print("Successflully saved customer to the Firebase db")
            }
        }
    }
    
    
    // MARK: User Actions & States
    func logOutUser() {
        if FIRAuth.auth()?.currentUser != nil {
            do {
                try FIRAuth.auth()?.signOut()
                GlobalSaver.shared.clearUser()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    
    // MARK: Fetch Users
    
    func fetchSelf(completion: @escaping (User) -> Void) {
        let thisUserRef = usersRef.child((currentUser?.uid)!)
        thisUserRef.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                print("Could not fetch user")
                return
            }
            completion(user)
        })
    }
    
}
