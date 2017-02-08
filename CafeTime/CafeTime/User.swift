//
//  User.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/1/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class User: NSObject {

    var uid: String = ""
    var name: String = ""
    var email: String = ""
    var password: String = ""
    var country: String = ""
    var profileImageURL: String = ""

    //image
    var myImageData: Data? = nil
    
    var requiredFields : [String] {
        return [name, email, password]
    }
    
    
}
