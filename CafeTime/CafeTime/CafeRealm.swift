//
//  CafeRealm.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/7/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit
import RealmSwift

class CafeRealm: Object {

    dynamic var uid: String? = ""
    dynamic var name: String? = ""
    dynamic var email: String? = ""
    dynamic var country: String? = ""
    dynamic var foodType: String? = ""
    dynamic var numberOfTables: String? = ""
    dynamic var profileImageURL: String? = ""
    
    override static func primaryKey() -> String? {
        return "uid"
    }
}
