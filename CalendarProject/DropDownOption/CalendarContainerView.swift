//
//  CalendarContainerView.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 6/28/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class CalendarContainerView: UIView {
    let defaults                = UserDefaults.standard
    var selectedDate            : Date!
    var isOpen                  = true
    var lineHeight : CGFloat    = 50
    var selectedLine            = 0
    var selectedDayNumber       = 0
    var calendarNavBar          = CalendarControlView()
    var calendarLinesArray      : [CalendarSingleLineView] = []
    var rowHeight               = 50
    var currentMonth            : Months!
    var currentYear             : Int!
    var currentLineArray        : [String] = []
    var weekdayLineArray        = ["S", "M", "T", "W", "T", "F", "S"]
    

    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureInitialSetup(month: .January, fourDigitYear: 2020)
        
    }
    
    init(date: Date) {
        super.init(frame: .zero)
        configure()
        let customDate = date.convertToCustomDateObject()
        configureInitialSetup(month: customDate.month, fourDigitYear: customDate.year)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        if let storedDate   = defaults.object(forKey: "selectedDate") as? Date {
            selectedDate    = storedDate
        } else {
            selectedDate    = Date()
            defaults.setValue(selectedDate, forKey: "selectedDate")
        }
        translatesAutoresizingMaskIntoConstraints   = false
        backgroundColor                             = .clear
    }
    
    private func configureInitialSetup(month: Months, fourDigitYear: Int) {
        currentMonth                    = month
        currentYear                     = fourDigitYear
        calendarNavBar.delegate         = self
        addSubview(calendarNavBar)
        let titleLine                   = CalendarSingleLineView()
        titleLine.heightWidth           = 40
        titleLine.isRounded             = true
        titleLine.set(bgColor: .systemBlue, textArray: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"])
        addSubview(titleLine)
        calendarLinesArray.append(titleLine)
//        calendarNavBar.layer.cornerRadius   = 15
//        calendarNavBar.layer.maskedCorners  = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        
        NSLayoutConstraint.activate([
            
            calendarNavBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            calendarNavBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            calendarNavBar.heightAnchor.constraint(equalToConstant: CGFloat(rowHeight)),
            calendarNavBar.topAnchor.constraint(equalTo: self.topAnchor),
            
            titleLine.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLine.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLine.heightAnchor.constraint(equalToConstant: CGFloat(rowHeight)),
            titleLine.topAnchor.constraint(equalTo: calendarNavBar.bottomAnchor)
        ])

        setUpComponents()
    }
    

    
    private func setUpComponents() {
        while calendarLinesArray.count > 1 {
            calendarLinesArray.last?.removeFromSuperview()
            calendarLinesArray.removeLast()
        }
        calendarNavBar.monthLabel.text  = "\(currentMonth.name), \(String(currentYear))"

        var datesArray : [String]       = []
        let initialDate                 = CustomDate(year: currentYear, date: 01, month: currentMonth, day: .none)
        let numberOfWeeks               = initialDate.getTotalWeeks()
        let firstOfMonth                = initialDate.getFirstOfMonth()
        let totalDays                   = initialDate.getNumberOfDaysInMonth()
        if firstOfMonth.rawValue != 0 {
            for _ in 1...firstOfMonth.rawValue {
                datesArray.append("")
            }
        }

        for x in 1...totalDays {
            datesArray.append(String(x))
        }
        while datesArray.count % 7 != 0 {
            datesArray.append("")
        }
        
        
        for x in 1...numberOfWeeks {
            let calenderLine        = CalendarSingleLineView()
            calenderLine.isCircle   = true
            calenderLine.set(bgColor: .systemBackground, textArray: [String(datesArray[0 + (7 * (x - 1))]), String(datesArray[1 + (7 * (x - 1))]), String(datesArray[2 + (7 * (x - 1))]), String(datesArray[3 + (7 * (x - 1))]), String(datesArray[4 + (7 * (x - 1))]), String(datesArray[5 + (7 * (x - 1))]), String(datesArray[6 + (7 * (x - 1))])])
            calendarLinesArray.append(calenderLine)
            calenderLine.delegate   = self
            calenderLine.tag        = x
            addSubview(calendarLinesArray[x])
            NSLayoutConstraint.activate([
                calendarLinesArray[x].leadingAnchor.constraint(equalTo: self.leadingAnchor),
                calendarLinesArray[x].trailingAnchor.constraint(equalTo: self.trailingAnchor),
                calendarLinesArray[x].heightAnchor.constraint(equalToConstant: CGFloat(rowHeight)),
                calendarLinesArray[x].topAnchor.constraint(equalTo: calendarLinesArray[x-1].bottomAnchor)
            ])
        }
//        calendarLinesArray.last!.layer.cornerRadius     = 15
//        calendarLinesArray.last!.layer.maskedCorners    = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        if selectedDate.convertToCustomDateObject().year == currentYear {
            if selectedDate.convertToCustomDateObject().month == currentMonth {
                for x in 1...numberOfWeeks {
                    for y in calendarLinesArray[x].labelArray {
                        if y.text == String(selectedDate.convertToCustomDateObject().date) {
                            y.backgroundColor = .systemGray
                        }
                    }
                }
            }
        }
    }
    

    
    // MARK: Tap Functions
    
    
    private func collapse(line: Int) {
        let durationTime : Double = 0.5
        UIView.animateKeyframes(withDuration: durationTime, delay: 0, options: .calculationModeCubicPaced) {
            var holderArray = self.calendarLinesArray
            
            for x in 0...self.calendarLinesArray.count - 1 {
                UIView.addKeyframe(withRelativeStartTime: (Double(x)/durationTime)/durationTime, relativeDuration: 1/durationTime) {
                    for y in holderArray {
                        y.frame = y.frame.offsetBy(dx: 0, dy: CGFloat((-self.rowHeight)))
                    }
                    holderArray.removeFirst()
                }
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                for x in self.calendarLinesArray {
                    x.layer.cornerRadius = 15
                    if x != self.calendarLinesArray[self.selectedLine] {
                        for y in x.labelArray {
                            y.alpha = 0
                        }
                    }
                }
                self.calendarNavBar.layer.cornerRadius = 15
                
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                for x in 0...self.calendarLinesArray[self.selectedLine].labelArray.count - 1 {
                    if self.calendarLinesArray[self.selectedLine].labelArray[x].text != String(self.selectedDayNumber) {
                        self.calendarLinesArray[self.selectedLine].labelArray[x].text = self.weekdayLineArray[x]
                        self.calendarLinesArray[self.selectedLine].labelArray[x].backgroundColor = .systemBlue
                    }

                }
 
            }
        } completion: { _ in

        }
        
    }
    private func expand() {
        UIView.animate(withDuration: 0.5) {
            for x in 0...self.calendarLinesArray.count - 1 {
                self.calendarLinesArray[x].frame = self.calendarLinesArray[x].frame.offsetBy(dx: 0, dy: CGFloat((self.rowHeight * x) + self.rowHeight))
            }
            for x in self.calendarLinesArray {
                x.layer.cornerRadius = 0
                if x != self.calendarLinesArray[self.selectedLine] {
                    for y in x.labelArray {
                        y.alpha = 1
                    }
                }
            }
            self.calendarNavBar.layer.cornerRadius = 0
            
        }
        
        for x in 0...self.calendarLinesArray[self.selectedLine].labelArray.count - 1 {
            if self.calendarLinesArray[self.selectedLine].labelArray[x].text != String(self.selectedDayNumber) {
                self.calendarLinesArray[self.selectedLine].labelArray[x].text = self.currentLineArray[x]
                self.calendarLinesArray[self.selectedLine].labelArray[x].backgroundColor = .systemBackground
            }

        }
        
    }
}

extension CalendarContainerView : CalendarDelegate {
    func tapOnLineItem(tag: Int, numSelected: Int) {
        selectedDayNumber = numSelected
        if isOpen {
            selectedLine = tag
            currentLineArray.removeAll()
            for x in calendarLinesArray[selectedLine].labelArray {
                currentLineArray.append(x.text!)
            }
            bringSubviewToFront(calendarLinesArray[selectedLine])
            self.layoutIfNeeded()
            for x in calendarLinesArray {
                x.cleanUp()
            }
            collapse(line: tag)
            isOpen          = false
            let dateHolder  = CustomDate(year: self.currentYear, date: numSelected, month: currentMonth, day: .none)
            selectedDate    = dateHolder.createDateFromCustomDate()

        } else {
            expand()
            isOpen = true
            for x in calendarLinesArray {
                x.cleanUp()
            }
        }
    }
}

extension CalendarContainerView : CalendarNavBarDelegate {
    func tapHandler(wasTapped: TapOptions) {
        switch wasTapped {
        case .left:
            previousMonth()
        case .center:
            return
        case .right:
            nextMonth()
        }
    }
    
    private func previousMonth() {
        var newMonth : Months!
        for x in Months.allCases {
            if x.rawValue == currentMonth.rawValue - 1 {
                newMonth = x
            }
        }
        if newMonth == nil {
            newMonth = .December
            currentYear -= 1
            
        }
        currentMonth = newMonth
        
        setUpComponents()
        
        
    }
    
    private func nextMonth() {
        var newMonth : Months!
        for x in Months.allCases {
            if x.rawValue == currentMonth.rawValue + 1 {
                newMonth = x
            }
        }
        if newMonth == nil {
            newMonth = .December
            currentYear += 1
            
        }
        currentMonth = newMonth
        
        setUpComponents()
        
    }
}
