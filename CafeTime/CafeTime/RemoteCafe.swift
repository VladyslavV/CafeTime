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


    // MARK: Server References
    
    private var cafesRef = FIRDatabase.database().reference(fromURL: "https://cafetime-6651e.firebaseio.com/").child("Cafes")
    private var dataBaseStorageRef = FIRStorage.storage().reference(forURL: "gs://cafetime-6651e.appspot.com/")
    
    
    
}
