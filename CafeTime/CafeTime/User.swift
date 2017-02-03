//
//  User.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/1/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class User: NSObject {

    //required
    var name: String = ""
    var email: String = ""
    var password: String = ""
    
    // optional
    var country: String = ""

    
    //image
    var myImageData: Data? = nil
    
    var requiredFields : [String] {
        return [name, email, password]
    }
    
    
    var optionalFields : [String] {
        return [country]
    }
  
    
}
