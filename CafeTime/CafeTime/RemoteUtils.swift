//
//  RemoteUtils.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/7/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RemoteUtils {

  
    static let shared = RemoteUtils()

    func checkUserExists(ref: FIRDatabaseReference, name: String, orderBy: String, compleion: @escaping (Bool) -> ()) {
        
        ref.queryOrdered(byChild: orderBy).queryEqual(toValue: name).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                compleion(true)
            } else {
                compleion(false)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // MARK: Delete file from firebase Storage
    func deleteFileAtPath(path: String, completion: @escaping (Bool) -> () ){
        
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
    
    // MARK: Delete data from firebase Database
    func deleteNodeFromFirebaseWithReference(ref: FIRDatabaseReference, completion: @escaping (Bool) -> () ) {
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
}
