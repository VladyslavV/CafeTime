//
//  UserJSON.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/30/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import FirebaseDatabase

struct User {
    
    var uid: String? = ""
    var name: String? = ""
    var email: String? = ""
    var country: String? = ""
    
    // MARK: - Create user with FirDataSnapshot
    
    init?(snapshot: FIRDataSnapshot) {
        if let firebaseDic = snapshot.value as? [String: AnyObject] {
            uid = snapshot.key
            name = firebaseDic["name"] as? String
            email = firebaseDic["email"] as? String
            country = firebaseDic["country"] as? String
        }
        else {
            print("Error retrieving data")
        }
        
    }
    
}
