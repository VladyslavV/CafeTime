//
//  NewsItemRealm.swift
//  Demo2
//
//  Created by Vladysalv Vyshnevksyy on 1/23/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import Foundation
import RealmSwift

class CustomerRealm: Object {
    
    dynamic var uid: String? = ""
    dynamic var name: String? = ""
    dynamic var email: String? = ""
    dynamic var password: String? = ""
    dynamic var country: String? = ""
    dynamic var profileImageURL: String? = ""

    override static func primaryKey() -> String? {
        return "uid"
    }
    
    
}
