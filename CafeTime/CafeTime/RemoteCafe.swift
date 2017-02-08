//
//  RemoteCafe.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/7/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RemoteCafe {
    
    private let daoCafe = ManagerDAO.access.cafe
    
    // MARK: Server References
    
    private var cafesRef = FIRDatabase.database().reference().child(Constants.Remote.References.Cafes)
    private var dataBaseStorageRef = FIRStorage.storage().reference()
    
    
    // MARK: Getter
    
    func fetchCurrentCafe(completion: @escaping (CafeRealm?) -> Void) {
        
        if let user = FIRAuth.auth()?.currentUser {
            
            if let existingUser = daoCafe.getByUid(uid: user.uid) {
                completion(existingUser)
            }
            
            cafesRef.child(user.uid).observeSingleEvent(of: .value , with: { [weak self] (snapshot) in
                
                guard let weakSelf = self else { return }
                
                if snapshot.key == user.uid {
                    completion(weakSelf.daoCafe.saveFromSnapshot(snapshot: snapshot, uid: user.uid))
                }
                else {
                    weakSelf.daoCafe.delete(withUID: user.uid)
                }
            })
        }
    }
    
    // MARK: Save Cafe
    
    func saveCafeToFirebase(cafe: Cafe, uid: String ,completion: @escaping (Bool) -> Void) {
        
        var userReference: FIRDatabaseReference?
        var values: [AnyHashable : Any]?
        
        //upload media to server
        RemoteUtils.shared.saveImageToFirebase(storageRef: dataBaseStorageRef.child("profile_images"), data: cafe.myImageData) { [weak self] (imageURL) in
            
            guard let weakSelf = self else { return }
            
            userReference = weakSelf.cafesRef.child(uid)
            let Values = Constants.Remote.Values.self
            values = [Values.Name : cafe.name, Values.Country : cafe.country, Values.Email : cafe.email, Values.FoodType : cafe.foodtype,
                      Values.NumberOfTables : cafe.numberOfTables, Values.ProfileImageURL  : imageURL.absoluteString,  Values.UID : uid]
            
            if let val = values, let ref = userReference {
                ref.updateChildValues(val) { (error, ref) in
                    if let err = error {
                        print(err)
                        completion(false)
                        return
                    }
                    completion(true)
                    print("Successfully saved cafe to the Firebase db")
                }
            }
        }
    }
}
