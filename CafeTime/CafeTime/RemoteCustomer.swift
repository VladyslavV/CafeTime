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
    
    private let daoCustomer = ManagerDAO.access.customer
    
    // MARK: Server References
    
    private var customersRef = FIRDatabase.database().reference(fromURL: "https://cafetime-6651e.firebaseio.com/").child("Customers")
    private var dataBaseStorageRef = FIRStorage.storage().reference(forURL: "gs://cafetime-6651e.appspot.com/")
    
    
    // MARK: Getter
    
    func fetchCurrentCustomer(completion: @escaping (CustomerRealm?) -> Void) {
        
        if let user = FIRAuth.auth()?.currentUser {
            
            if let existingUser = daoCustomer.getByUid(uid: user.uid) {
                completion(existingUser)
            }
            
            customersRef.child(user.uid).observeSingleEvent(of: .value , with: { [weak self] (snapshot) in
                
                guard let weakSelf = self else { return }
                                
                if snapshot.key == user.uid {
                    completion(weakSelf.daoCustomer.saveFromSnapshot(snapshot: snapshot, uid: user.uid))
                }
                else {
                    weakSelf.daoCustomer.delete(withUID: user.uid)
                }
            })
        }
    }
    
    // MARK: Save user
    
    func saveCustomerToFirebase(customer: Customer, uid: String ,completion: @escaping (Bool) -> Void) {
        
        var userReference: FIRDatabaseReference?
        var values: [AnyHashable : Any]?
        
        //upload media to server
        RemoteUtils.shared.saveImageToFirebase(storageRef: dataBaseStorageRef.child("profile_images"), data: customer.myImageData) { [weak self] (imageURL) in
            
            guard let weakSelf = self else { return }
            
            userReference = weakSelf.customersRef.child(uid)
            values = ["name" : customer.name, "country" : customer.country, "email" : customer.email, "profileImageURL" : imageURL.absoluteString]
            
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
        }
    }
}
