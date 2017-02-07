//
//  Cafe.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/1/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class Cafe: User {
    
    var foodtype: String = ""
    var numberOfTables: String = ""
    
    override var requiredFields : [String] {
        return [name, email, password, numberOfTables]
    }


}
