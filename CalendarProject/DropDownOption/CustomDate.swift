//
//  CustomDate.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 6/28/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

struct CustomDate {
    var year    : Int
    var date    : Int
    var month   : Months
    var day     : Days
    
    
    
    func getFirstOfMonth() -> Days {
        let stringDate              = "\(self.year)-\(self.month.rawValue)-01"
        let dateFormatter           = DateFormatter()
        dateFormatter.locale        = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat    = "yyyy-MM-dd"
        let date = dateFormatter.date(from: stringDate)!
        dateFormatter.dateFormat    = "EEEE"
        var day : Days!
        for x in Days.allCases {
            if "\(x)" == dateFormatter.string(from: date) {
                day = x
            }
        }
        return day
    }
    
    func getNumberOfDaysInMonth() -> Int {
        var totalDaysInMonth    : Int!
        let isLeapYear          = (year % 4 == 0) ? true : false
        switch month.rawValue {
        case 2:
            totalDaysInMonth    = isLeapYear ? 29 : 28
        case 1,3,5,7,8,10,12:
            totalDaysInMonth    = 31
        default:
            totalDaysInMonth    = 30
        }
        return totalDaysInMonth
    }
    
    func getWeekNumber() -> Int {
        var weekCounter     = 1
        let daysInFirstWeek = getFirstOfMonth().rawValue
        var intHolder       = date
        while intHolder > 7 {
            intHolder -= 7
            weekCounter += 1
        }
        if intHolder > month.rawValue {
            weekCounter += 1
        }
        return weekCounter
    }
    
    func getTotalWeeks() -> Int {
        let totalDaysInMonth    = getNumberOfDaysInMonth()
        var weekCounter         = 1
        var intHolder           = 1
        let firstDay            = getFirstOfMonth().rawValue
        while intHolder <= totalDaysInMonth - 7 {
            intHolder += 7
            weekCounter += 1
        }
        if totalDaysInMonth - intHolder + firstDay > 6 {
            weekCounter += 1
        }
        return weekCounter
    }
    
    func createDateFromCustomDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: "\(year)-\(month.rawValue)-\(date)") else { return nil }
        return date
    }
}


