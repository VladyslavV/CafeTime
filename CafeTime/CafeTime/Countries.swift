//
//  Countries.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 1/30/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

import UIKit

class Countries: NSObject {

    var countries = [String]()
    
    override init() {
        countries = NSLocale.isoCountryCodes.map { (code:String) -> String in
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let currentLocaleID = NSLocale.current.identifier
            return NSLocale(localeIdentifier: currentLocaleID).displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
        }
        countries = countries.sorted { $0 < $1 }
    }
}
