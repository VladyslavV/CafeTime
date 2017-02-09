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
    
    private var customersRef = FIRDatabase.database().reference().child(Constants.Remote.References.Customers)
    private var dataBaseStorageRef = FIRStorage.storage().reference()
    
    
    // MARK: Getters
    
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
    
    func fetchCustomer(withUID uid: String, completion: @escaping (Customer?) -> Void) {
        
        if (FIRAuth.auth()?.currentUser) != nil {
            customersRef.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dict = snapshot.value as? [String : AnyObject] {
                    let customer = Customer()
                    customer.setValuesForKeys(dict)
                    completion(customer)
                }
            })
        }
    }
    
    private var customersObserver : FIRDatabaseHandle?
    func fetchAllCustomers(completion: @escaping ([Customer]?) -> ()) {
        
        if (FIRAuth.auth()?.currentUser) != nil {
            var customersArray = [Customer]()
            customersObserver = customersRef.observe(.childAdded, with: { (snapshot) in
                
                if let dict = snapshot.value as? [String : AnyObject] {
                    let customer = Customer()
                    customer.setValuesForKeys(dict)
                    customersArray.append(customer)
                    completion(customersArray)
                }
            })
        }
    }
    
    func removeCustomersObserver() {
        if let observer = customersObserver {
            customersRef.removeObserver(withHandle: observer)
        }
    }
    
    // MARK: Save user
    
    func saveCustomerToFirebase(customer: Customer, imageData : Data?, uid: String ,completion: @escaping (Bool) -> Void) {
        
        var userReference: FIRDatabaseReference?
        var values: [AnyHashable : Any]?
        
        //upload media to server
        RemoteUtils.shared.saveImageToFirebase(storageRef: dataBaseStorageRef.child("profile_images"), data: imageData) { [weak self] (imageURL) in
            
            guard let weakSelf = self else { return }
            
            userReference = weakSelf.customersRef.child(uid)
            customer.uid = uid
            if let imageurl = imageURL?.absoluteString {
                customer.profileImageURL = imageurl
            }
            values = Utils.shared.getDictFromUser(user: customer)
            
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

