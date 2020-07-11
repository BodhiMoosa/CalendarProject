//
//  Date+Ext.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 6/28/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

extension Date {
    func getDayInt() -> Int {
        let calendar = Calendar.current
        return calendar.component(.day, from: self)
    }
    
    func getDayName() -> String {
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "EEEE"
        return dateFormatter.string(from: self)
        
    }
    
    func getDateData() -> [String : Any] {
        var dict : [String : Any]   = [:]
        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "EEEE"
        dict["dayString"]           = dateFormatter.string(from: self)
        dateFormatter.dateFormat    = "MMMM"
        dict["monthString"]         = dateFormatter.string(from: self)
        dateFormatter.dateFormat    = "d"
        dict["dayInt"]              = Int(dateFormatter.string(from: self))
        dateFormatter.dateFormat    = "yyyy"
        dict["yearInt"]             = Int(dateFormatter.string(from: self))
                
        return dict
    }
    
    
    
    func convertToCustomDateObject() -> CustomDate? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat    = "yyyy"
        guard let year              = Int(dateFormatter.string(from: self)) else { return nil }
        dateFormatter.dateFormat    = "d"
        guard let dayInt            = Int(dateFormatter.string(from: self)) else { return nil }
        dateFormatter.dateFormat    = "EEEE"
        var day                     : Days!
        for x in Days.allCases {
            if "\(x)" == dateFormatter.string(from: self) {
                day = x
            }
        }
        dateFormatter.dateFormat    = "MMMM"
        var month                   : Months!
        for x in Months.allCases {
            if "\(x)" == dateFormatter.string(from: self) {
                month = x
            }
        }
        return CustomDate(year: year, date: dayInt, month: month, day: day)
    }
}
