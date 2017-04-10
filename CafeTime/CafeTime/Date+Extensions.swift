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
    
    static func compareDate(date1: Date, date2: Date, byComponent component: Calendar.Component) -> Bool {
        let order = Calendar.current.compare(date1, to: date2, toGranularity: component)
        switch order {
        case .orderedSame:
            return true
        default:
            return false
        }
    }
    
    func startOfMonth() -> Date? {
        
        let calendar = Calendar.current
        let currentDateComponents = calendar.dateComponents([.year, .month], from: self)
        let startOfMonth = calendar.date(from: currentDateComponents)
        
        return startOfMonth
    }
    
    func dateByAddingMonths(_ monthsToAdd: Int) -> Date? {
        
        let calendar = Calendar.current
        var months = DateComponents()
        months.month = monthsToAdd
        
        return calendar.date(byAdding: months, to: self)
    }
    
    func endOfMonth() -> Date? {
        
        guard let plusOneMonthDate = dateByAddingMonths(1) else { return nil }
        
        let calendar = Calendar.current
        let plusOneMonthDateComponents = calendar.dateComponents([.year, .month], from: plusOneMonthDate)
        let endOfMonth = calendar.date(from: plusOneMonthDateComponents)?.addingTimeInterval(-1)
        
        return endOfMonth
        
    }
}
