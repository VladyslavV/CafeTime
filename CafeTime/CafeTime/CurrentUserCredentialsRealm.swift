//
//  CurrentUserCredentials.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/31/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import Foundation
import RealmSwift

class CurrentUserCredentialsRealm: Object {

    dynamic var email = ""
    dynamic var password = ""

}
