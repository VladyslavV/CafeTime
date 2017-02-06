//
//  AuthManager+Extension_DeleteObjectsFromServer.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/6/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import Foundation
import Firebase

extension AuthManager {
    
    // MARK: Delete User
    
    // delete self ... need to test if connection is valid
    func deleteCurrentUser(completion: @escaping (String,Bool) -> () ) {
        
        if !isFirebaseConnectionActive {
            completion("No connection", false)
            return
        }
        
        if let currentUser = FIRAuth.auth()?.currentUser {
        
            //delete from Realm
            self.dao.deleteUser(withUID: currentUser.uid)
            
            let ref = self.customersRef.child(currentUser.uid)
            
            self.deleteNodeFromFirebaseWithReference(ref: ref, completion: { (success) in
                
                if !success {
                    completion("Couldn't delete users data", false)
                    return
                }
                
                // auth sensitive --- requires recent login 
                currentUser.delete(completion: { [weak self] (error) in
                    
                    guard let weakSelf = self else { return }
                    if let err = error {
                        print(err.localizedDescription)
                        completion(err.localizedDescription, false)
                        return
                    }
                    
                    weakSelf.logOutUser()
                    completion("", true)
                })
            })
        }
    }
    
    private func deleteNodeFromFirebaseWithReference(ref: FIRDatabaseReference, completion: @escaping (Bool) -> () ) {
        ref.observeSingleEvent(of: .value, with: { (snapshot) -> Void in
            snapshot.ref.removeValue(completionBlock: { (error, reference) in
                if let err = error {
                    print(err.localizedDescription)
                    completion(false)
                    return
                }
                completion(true)
            })
        })
    }
    
    // MARK: Delete File
    private func deleteFileAtPath(path: String, completion: @escaping (Bool) -> () ){
        
        let objectToDeletePath = FIRStorage.storage().reference(forURL: path)
        objectToDeletePath.delete { (error) in
            if let err = error {
                print(err)
                completion(false)
                return
            }
            completion(true)
        }
    }
}
