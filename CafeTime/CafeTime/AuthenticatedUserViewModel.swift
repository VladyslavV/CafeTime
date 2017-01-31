//
//  AuthenticatedModelView.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/31/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class AuthenticatedUserViewModel: NSObject {

    private let authManager = AuthManager.shared

    var userName: String? = ""
    var userEmail: String? = ""
    var userCountry: String? = ""

    override init() {
        let realm = RealmManager()
        if let user = realm.localUser {
            userName = user.name
            userEmail = user.email
            userCountry = user.country
        }
    }

    func updateModel(completion: (Bool) -> Void) {
        authManager.fetchSelf { [weak self] (user) in
            guard let weakSelf = self else { return }
            weakSelf.userName = user.name
            weakSelf.userEmail = user.email
            weakSelf.userCountry = user.country

        }
    }
    
    
}
