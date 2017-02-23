//
//  File.swift
//  CafeTime
//
//  Created by Vladysalv Vyshnevksyy on 2/23/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

extension UUID {
    
    static public func ==(lhs: UUID, rhs: UUID) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
