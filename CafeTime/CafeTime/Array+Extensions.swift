//
//  Array+Extensions.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/20/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

extension Array {
    
    static func arrayOfKeysFromListOfDictionaries<T>(list: T) -> [String] {
        
        var keysArray = [String]()

        if let theList = list as? [[String : AnyObject]] {
            for dict in theList {
                if let key = dict.keys.first {
                    keysArray.append(key)
                }
            }

        }
        return keysArray
    }
    
    static func arrayOfValuesFromListOfDictionaries<T>(list: T) -> [Any] {
        
        var valuesArray = [Any]()
        
        if let theList = list as? [[String : AnyObject]] {
            for dict in theList {
                if let value = dict.values.first {
                    valuesArray.append(value)
                }
            }
            
        }
        return valuesArray
    }

}
