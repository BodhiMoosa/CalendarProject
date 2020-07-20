//
//  Date+Ext.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 6/28/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

enum DateFormatOptions : String {
    case yearNoPadding          = "y"
    case yearTwoDigits          = "yy"
    case yearFourDigitPadding   = "yyyy"
    
    case monthNoPadding         = "M"
    case monthWithPadding       = "MM"
    case monthShorthand         = "MMM"
    case monthFullName          = "MMMM"
    
    case dayNoPadding           = "d"
    case dayWithPadding         = "dd"
    case dayAbbreviated         = "E"
    case dayFullName            = "EEEE"
    case dayTwoLetter           = "EEEEEE"
    
}

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
    
    
    
    func convertToCustomDateObject() -> CustomDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat    = "yyyy"
        guard let year              = Int(dateFormatter.string(from: self)) else { return CustomDate(year: 1988, date: 14, month: .July, day: .Thursday) }
        dateFormatter.dateFormat    = "d"
        guard let dayInt            = Int(dateFormatter.string(from: self)) else { return CustomDate(year: 1988, date: 14, month: .July, day: .Thursday) }
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
    
    func getSevenDayWeeks(numOfMonthsOffset: Int) -> [[String]] {
        var arrayOfArrays : [[String]] = [[]]

        let dateFormatter           = DateFormatter()
        dateFormatter.dateFormat    = "M"
        var monthInt                = Int(dateFormatter.string(from: self))!
        var numOfMonthsOffset       = numOfMonthsOffset
        var numOfYearsOffset        = 0
        
        while numOfMonthsOffset >= 12 {
            numOfMonthsOffset -= 12
            numOfYearsOffset += 1
        }
        
        while numOfMonthsOffset <= -12 {
            numOfMonthsOffset += 12
            numOfYearsOffset -= 1
 
        }
        
        monthInt += numOfMonthsOffset
        if monthInt > 12 {
            monthInt = monthInt - 12
        } else if monthInt < 1 {
            monthInt = 12 + monthInt
        }

        dateFormatter.dateFormat = "yyyy"
        let year                 = Int(dateFormatter.string(from: self))! + numOfYearsOffset
        dateFormatter.dateFormat = "MMMM"
        var month               : Months!
        
        for x in Months.allCases {
            if x.rawValue == monthInt {
                month = x
            }
        }
        
        arrayOfArrays.append([String(describing: month!), String(year)])

        dateFormatter.dateFormat = "yyyy-M-d"
        guard let date = dateFormatter.date(from: "\(year)-\(month.rawValue)-\(1)") else {return [[]] }
        
        let totalDaysInMonth    : Int!
        let isLeapYear          = (year % 4 == 0) ? true : false
        switch month.rawValue {
        case 2:
            totalDaysInMonth    = isLeapYear ? 29 : 28
        case 1,3,5,7,8,10,12:
            totalDaysInMonth    = 31
        default:
            totalDaysInMonth    = 30
        }
        
        dateFormatter.dateFormat    = "EEEE"
        var day                     : Days!
        for x in Days.allCases {
            if "\(x)" == dateFormatter.string(from: date) {
                day = x
            }
        }

        var holderArray : [String] = []
        var numHolder = day.rawValue
        while numHolder > 0 {
            holderArray.append("")
            numHolder -= 1
        }
        for x in 1...totalDaysInMonth {
            holderArray.append(String(x))
        }
        

        while holderArray.count > 7 {
            let array = Array(holderArray[0..<7])
            arrayOfArrays.append(array)
            holderArray.removeSubrange(0...6)
        }
        var finalArray : [String] = []
        for x in holderArray {
            finalArray.append(x)
        }
        while finalArray.count < 7 {
            finalArray.append("")
        }
        arrayOfArrays.append(finalArray)
        
        arrayOfArrays.removeFirst()
        return arrayOfArrays
        
    }
    
    func getWeekArrays(month: Months, year: Int) -> [[String]] {
        
        var arrayOfArrays : [[String]]  = [[]]
        arrayOfArrays.append([String(describing: month), String(year)])
        let dateFormatter               = DateFormatter()
        
        dateFormatter.dateFormat        = "yyyy-M-d"
        guard let date = dateFormatter.date(from: "\(year)-\(month.rawValue)-\(1)") else {return [[]] }
        
        let totalDaysInMonth    : Int!
        let isLeapYear          = (year % 4 == 0) ? true : false
        switch month.rawValue {
        case 2:
            totalDaysInMonth    = isLeapYear ? 29 : 28
        case 1,3,5,7,8,10,12:
            totalDaysInMonth    = 31
        default:
            totalDaysInMonth    = 30
        }
        
        dateFormatter.dateFormat    = "EEEE"
        var day                     : Days!
        for x in Days.allCases {
            if "\(x)" == dateFormatter.string(from: date) {
                day = x
            }
        }

        var holderArray : [String] = []
        var numHolder = day.rawValue
        while numHolder > 0 {
            holderArray.append("")
            numHolder -= 1
        }
        for x in 1...totalDaysInMonth {
            holderArray.append(String(x))
        }
        

        while holderArray.count > 7 {
            let array = Array(holderArray[0..<7])
            arrayOfArrays.append(array)
            holderArray.removeSubrange(0...6)
        }
        var finalArray : [String] = []
        for x in holderArray {
            finalArray.append(x)
        }
        while finalArray.count < 7 {
            finalArray.append("")
        }
        arrayOfArrays.append(finalArray)
        
        arrayOfArrays.removeFirst()
        return arrayOfArrays
        
        
    }

    
    
 
}

