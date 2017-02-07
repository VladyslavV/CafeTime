//
//  RemoteUser.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/7/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RemoteCustomer {
    
    private let dao = UserDAO()
    
    // MARK: Server References
    
    private var customersRef = FIRDatabase.database().reference(fromURL: "https://cafetime-6651e.firebaseio.com/").child("Customers")
    private var dataBaseStorageRef = FIRStorage.storage().reference(forURL: "gs://cafetime-6651e.appspot.com/")

    
    // MARK: Getter
    
    func fetchCurrentCustomer(completion: @escaping (UserRealm?) -> Void) {
        
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
    
    // MARK: Save user

    func saveUserToFirebase(user: User, uid: String ,completion: @escaping (Bool) -> Void) {
        
        var userReference: FIRDatabaseReference?
        var values: [AnyHashable : Any]?
        
        //upload media to server
        self.saveUserMediaToFirebase(user: user, completion: { [weak self] (imageURL) in
            
            guard let weakSelf = self else { return }
            
            userReference = weakSelf.customersRef.child(uid)
            values = ["name" : user.name, "country" : user.country, "email" : user.email, "profileImageURL" : imageURL.absoluteString]
            
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
    
    
    // MARK: Delete User
    
    // delete self ... need to relogin
    func deleteCurrentUser(completion: @escaping (String,Bool) -> () ) {
        
        if let currentUser = FIRAuth.auth()?.currentUser {
            
            //delete from Realm
            self.dao.deleteUser(withUID: currentUser.uid)
            
            let ref = self.customersRef.child(currentUser.uid)
            
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
