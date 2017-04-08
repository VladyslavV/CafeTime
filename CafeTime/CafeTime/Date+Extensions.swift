//
//  Date+Extensions.swift
//  CafeTime
//
//  Created by Vladyslav Vyshnevksyy on 4/8/17.
//  Copyright © 2017 Vladysalv Vyshnevksyy. All rights reserved.
//

extension Date {
    func currentTimeZoneDate() -> String {
        let dtf = DateFormatter()
        dtf.timeZone = TimeZone.current
        dtf.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dtf.string(from: self)
    }
}
