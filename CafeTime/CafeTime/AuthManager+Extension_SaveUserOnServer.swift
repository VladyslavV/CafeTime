//
//  AuthManager+Extension.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/3/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import Firebase

extension AuthManager {
    
    // MARK: Create and Save user
    func createUser(user : User, rememberUser: Bool, completion: @escaping (_ error: String, _ success: Bool) -> Void) {
        
        if !isFirebaseConnectionActive {
            completion("No connection", false)
            return
        }
        
        self.checkUserExistsWithName(name: user.name) { (exists) in
            
            if exists {
                completion("User with this name already exists", false)
            }
            else {
                FIRAuth.auth()?.createUser(withEmail: user.email, password: user.password, completion: { [weak self] (firUser, error) in
                    
                    guard let weakSelf = self else { return }
                    
                    if let err = error {
                        completion(err.localizedDescription, false)
                        return
                    }
                    print("You have successfully signed up")
                    
                    // save locally
                    if rememberUser {
                        let dao = DAO()
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
        }
    }
    
    private func checkUserExistsWithName(name: String, compleion: @escaping (Bool) -> () ) {
        customersRef.queryOrdered(byChild: "name").queryEqual(toValue: name).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                compleion(true)
            } else {
                compleion(false)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    private func saveUserToFirebase(user: User, uid: String ,completion: @escaping (Bool) -> Void) {
        
        var userReference: FIRDatabaseReference?
        var values: [AnyHashable : Any]?
        
        //upload media to server
        self.saveUserMediaToFirebase(user: user, completion: { [weak self] (imageURL) in
            
            guard let weakSelf = self else { return }
            
            if user.isKind(of: Cafe.self) {
                if let cafe = user as? Cafe {
                    userReference = weakSelf.cafesRef.child(uid)
                    values = ["name" : cafe.name, "country" : cafe.country, "email" : cafe.email, "numberOfTables" : cafe.numberOfTables, "profileImageURL" : imageURL.absoluteString,
                              "foodTpye" : cafe.foodtype]
                }
            }
            else {
                userReference = weakSelf.customersRef.child(uid)
                values = ["name" : user.name, "country" : user.country, "email" : user.email, "profileImageURL" : imageURL.absoluteString]
            }
            
            if let val = values, let ref = userReference {
                ref.updateChildValues(val) { (error, ref) in
                    if let err = error {
                        print(err)
                        completion(false)
                        return
                    }
                    completion(true)
                    print("Successfully saved customer to the Firebase db")
                }
            }
        })
    }
    
    private func saveUserMediaToFirebase(user: User, completion: @escaping (URL) -> () ) {
        
        if let data = user.myImageData {
            
            let imageName = NSUUID().uuidString
            dataBaseStorageRef.child("profile_images").child("\(imageName).jpg").put(data, metadata: nil, completion: { (metadata, error) in
                
                if let err = error {
                    print(err)
                    return
                }
                
                if let imageURL = metadata?.downloadURL() {
                    completion(imageURL)
                }
            })
        }
    }
}
