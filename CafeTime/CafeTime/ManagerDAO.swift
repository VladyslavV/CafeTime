//
//  RealmManager.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/31/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import Foundation
import RealmSwift

class ManagerDAO {
    
    static let access = ManagerDAO()
    private init () { }
    
    private let realm = try! Realm()
    
    var customer = CustomerDAO()
    var cafe = Cafe()
    var credentials = CredentialsDAO()
    
    //    lazy var allNews: Results<NewsItemRealm> = {
    //        self.realm.objects(NewsItemRealm.self)
    //    }()
    
    func clearRealm() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}

