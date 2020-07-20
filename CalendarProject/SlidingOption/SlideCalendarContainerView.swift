//
//  SlideCalendarContainerView.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 7/13/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

enum SwipeDirection {
    case left
    case right
    
}

protocol SlidingCalendarDelegate : class {
    func didSelectDate(day: Int, month: Months, year: Int)
}


protocol PassBackToNavBar : class {
    func passBackBackgroundColor(color: UIColor)
    func passBackLabelColor(color: UIColor)
    func passBackSelectedColor(color: UIColor)
    func passBackSelectedDay(arraySpot: Int?)
    func passBackMonthTitle(month: String)
    func passBackMonthTitleTextColor(color: UIColor)
}

protocol PassBackToDaysBar : class {
    func passBackBackgroundColor(color: UIColor)
    func passBackUnselectedTextColor(color: UIColor)
    func passBackSelectedTextColor(color: UIColor)
    func passBackSelectedDateBackgroundColor(color: UIColor)
    func passBackIsSelected(date: Int)
    
}



class SlideCalendarContainerView: UIView {
    
    // MARK: Two delegates to pass to child views and one to pass to parent view
    weak var passBackToDaysDelegate                 : PassBackToDaysBar!
    weak var passBackToNavDelegate                  : PassBackToNavBar!
    weak var delegate                               : SlidingCalendarDelegate!
    
    // MARK: Declaring child views
    private var titleBar                                    = SliderOptionTitleBar()
    private var daysBar                                     : SliderOptionDaysView!
    private var newDayBar                                   : SliderOptionDaysView!
    
    
    private let defaults                                    = UserDefaults.standard
    private var selectedDate                                : Date!
    private var monthOffset                                  = 0
    private var currentlyDisplayedWeek                      : Int!
    private var currentlyDisplayedMonthArray : [[String]]   = []
    private var selectedDayInt  : Int!
    private var selectedMonth   : Months!
    private var selectedYear    : Int!
    private var isBorderSet     = false
    
    // MARK: Variables to modify the behavior of the custom class
    
    var setBorderColor : UIColor = .systemGray {
        didSet {
            if isBorderSet {
                for x in 10...13 {
                    if let view = viewWithTag(x) {
                        view.backgroundColor = setBorderColor
                    }
                }
            } else {
                return
            }
        }
    }
    
    var borderWidth : CGFloat = 0 {
        didSet {
            if isBorderSet {
                for x in 10...13 {
                    if let view = viewWithTag(x) {
                        view.removeFromSuperview()
                    }
                }
                borderSides(sides: setBorderSides, borderColor: setBorderColor, borderWidth: borderWidth)
            } else {
                return
            }
        }
    }
    
    var monthLabelColor : UIColor = .label {
        didSet {
            passBackToNavDelegate.passBackMonthTitleTextColor(color: monthLabelColor)

        }
    }
    
    var setBorderSides : [Sides] = [] {
        didSet {
            borderSides(sides: setBorderSides, borderColor: setBorderColor, borderWidth: borderWidth)
            isBorderSet = true
        }
    }
    
    var calendarSelectedHighlightColor : UIColor = .systemPink {
        didSet {
            passBackToDaysDelegate.passBackSelectedDateBackgroundColor(color: calendarSelectedHighlightColor)
        }
    }
    var calendarDaysSelectedTextColor : UIColor = .systemBackground {
        didSet {
            passBackToDaysDelegate.passBackSelectedTextColor(color: calendarDaysSelectedTextColor)
        }
    }
    
    var calendarDaysTextColor : UIColor = .label {
        didSet {
            passBackToDaysDelegate.passBackUnselectedTextColor(color: calendarDaysTextColor)
        }
    }
    var calendarDaysBackgroundColor : UIColor = .systemBackground {
        didSet {
            passBackToDaysDelegate.passBackBackgroundColor(color: calendarDaysBackgroundColor)
        }
    }
    
    var calendarNavBarBackgroundColor : UIColor = .systemBackground {
        didSet {
            passBackToNavDelegate.passBackBackgroundColor(color: calendarNavBarBackgroundColor)
        }
    }
    
    var calendarNavBarSelectedColor : UIColor = .systemPink {
        didSet {
            passBackToNavDelegate.passBackSelectedColor(color: calendarNavBarSelectedColor)
        }
    }
    
    var calendarNavBarDaysTextColor : UIColor = .label {
        didSet {
            passBackToNavDelegate.passBackLabelColor(color: calendarNavBarDaysTextColor)
        }
    }
    

    
    var cornerRadiusForCalendar : CGFloat = 0 {
        didSet{
            titleBar.layer.cornerRadius = cornerRadiusForCalendar
            daysBar.layer.cornerRadius  = cornerRadiusForCalendar
        }
    }
    
    
    
    override func didMoveToSuperview() {
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureSlideFunctionality()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        
        // MARK: Set up initial view containing the displayed dates
        daysBar                                     = SliderOptionDaysView()
        daysBar.delegate                            = self
        daysBar.backgroundColor                     = calendarDaysBackgroundColor
        daysBar.layer.maskedCorners                 = CACornerMask(arrayLiteral: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        daysBar.layer.cornerRadius                  = cornerRadiusForCalendar
        
        // MARK: Set up the navigation view, including the day names and month name
        titleBar.backgroundColor                    = calendarNavBarBackgroundColor
        titleBar.layer.maskedCorners                = CACornerMask(arrayLiteral: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        titleBar.layer.cornerRadius                 = cornerRadiusForCalendar
        
        // MARK: Add Views
        addSubview(titleBar)
        addSubview(daysBar)
        passBackToNavDelegate.passBackMonthTitleTextColor(color: calendarNavBarDaysTextColor)

        NSLayoutConstraint.activate([
            titleBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleBar.topAnchor.constraint(equalTo: self.topAnchor),
            titleBar.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
            
            daysBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            daysBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            daysBar.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
            daysBar.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        // MARK: If there is no selected date, it makes 'today' the selected date so it will show the current week.
        
        if let storedDate   = defaults.object(forKey: "selectedDate") as? Date {
            selectedDate    = storedDate
        } else {
            selectedDate    = Date()
            defaults.setValue(selectedDate, forKey: "selectedDate")
        }
        
        // MARK: This function gets the total number of days for the month, puts them into 7-day arrays, and adds blanks for the days before 1 and after the last day
        currentlyDisplayedMonthArray = selectedDate.getSevenDayWeeks(numOfMonthsOffset: 0)
        
        // MARK: This finds the week within the array of weeks we set above^ and saves that position as 'currentlyDisplayedWeek'
        for x in 0...currentlyDisplayedMonthArray.count - 1 {
            if currentlyDisplayedMonthArray[x].contains(String(selectedDate.getDayInt())) {
                currentlyDisplayedWeek = x
            }
        }
        
        // MARK: This uses a function within the dayBar to set the days based on the data we just got above^
        daysBar.set(datesFromMonToFri: currentlyDisplayedMonthArray[currentlyDisplayedWeek])
        
        // MARK: This gets the month by comparing all available month options against the month name, which we have in the array of weeks
        // It then sets the titleBar's monthLabel's text to that month's name
        for x in Months.allCases {
            if x.name == currentlyDisplayedMonthArray[0][0] {
                selectedMonth = x
                passBackToNavDelegate.passBackMonthTitle(month: selectedMonth.name)
            }
        }
        
        // MARK: This saves the selected date and year of the currently selected date (might not be needed, come back to this)
        selectedYear    = Int(currentlyDisplayedMonthArray[0][1])
        selectedDayInt  = selectedDate.getDayInt()
        configureSelectedDateVisual()
        

    }
    
    private func configureSlideFunctionality() {
        let slideGesture = UIPanGestureRecognizer(target: self, action: #selector(slideDays(sender:)))
        daysBar.addGestureRecognizer(slideGesture)
    }
    
    @objc func slideDays(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.daysBar)
        switch sender.state {
        case .ended:
            if translation.x < -5 {
                shiftWeeks(direction: .left)
            } else if translation.x > 5 {
                shiftWeeks(direction: .right)
            }
            
        default:
            return
        }
        
    }
    
    func shiftWeeks(direction: SwipeDirection) {
        let distance : CGFloat  = direction == .left ? UIScreen.main.bounds.width : -UIScreen.main.bounds.width
        newDayBar               = SliderOptionDaysView()
        newDayBar.delegate      = self
        let slideGesture        = UIPanGestureRecognizer(target: self, action: #selector(slideDays(sender:)))
        newDayBar.addGestureRecognizer(slideGesture)
        let startinglead        = newDayBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: distance)
        let endinglead          = newDayBar.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        addSubview(newDayBar)
        NSLayoutConstraint.activate([
            newDayBar.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            newDayBar.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
            newDayBar.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        startinglead.isActive = true
        layoutIfNeeded()
        passBackToDaysDelegate.passBackSelectedTextColor(color: calendarDaysSelectedTextColor)
        passBackToDaysDelegate.passBackSelectedDateBackgroundColor(color: calendarSelectedHighlightColor)
        weekTransition(direction: direction)
        self.newDayBar.layer.cornerRadius = self.cornerRadiusForCalendar
        self.newDayBar.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
        UIView.animate(withDuration: 0.5, delay: 0) {
            self.daysBar.frame      = self.daysBar.frame.offsetBy(dx: -distance, dy: 0)
            self.newDayBar.frame    = self.newDayBar.frame.offsetBy(dx: -distance, dy: 0)
            
        } completion: { _ in
            self.newDayBar.backgroundColor = self.calendarDaysBackgroundColor
            self.daysBar.removeFromSuperview()
            self.daysBar            = nil
            startinglead.isActive   = false
            endinglead.isActive     = true
            self.daysBar            = self.newDayBar
            self.newDayBar          = nil

            self.configureSelectedDateVisual()
        }
        
    }
    
    private func weekTransition(direction: SwipeDirection) {
        if direction == .right {
            if currentlyDisplayedWeek > 1 {
                currentlyDisplayedWeek -= 1
                newDayBar.set(datesFromMonToFri: currentlyDisplayedMonthArray[currentlyDisplayedWeek])
            } else {
                monthOffset                     -= 1
                currentlyDisplayedMonthArray    = selectedDate.getSevenDayWeeks(numOfMonthsOffset: monthOffset)
                currentlyDisplayedWeek          = currentlyDisplayedMonthArray.count - 1
                passBackToNavDelegate.passBackMonthTitle(month: currentlyDisplayedMonthArray[0][0])
                newDayBar.set(datesFromMonToFri: currentlyDisplayedMonthArray[currentlyDisplayedWeek])
            }
        } else {
            if currentlyDisplayedWeek < currentlyDisplayedMonthArray.count - 1 {
                currentlyDisplayedWeek += 1
                newDayBar.set(datesFromMonToFri: currentlyDisplayedMonthArray[currentlyDisplayedWeek])
            } else {
                monthOffset                     += 1
                currentlyDisplayedMonthArray    = selectedDate.getSevenDayWeeks(numOfMonthsOffset: monthOffset)
                currentlyDisplayedWeek          = 1
                passBackToNavDelegate.passBackMonthTitle(month: currentlyDisplayedMonthArray[0][0])
                newDayBar.set(datesFromMonToFri: currentlyDisplayedMonthArray[currentlyDisplayedWeek])
            }
        }
        
        passBackToDaysDelegate.passBackUnselectedTextColor(color: calendarDaysTextColor)
        passBackToDaysDelegate.passBackBackgroundColor(color: calendarDaysBackgroundColor)
        passBackToNavDelegate.passBackSelectedDay(arraySpot: nil)
        
        
        

    }
    
    private func configureSelectedDateVisual() {
        if selectedDayInt != nil {
            if currentlyDisplayedMonthArray[0][0] == selectedMonth.name {
                if currentlyDisplayedMonthArray[0][1] == String(selectedYear) {
                    for x in 0...currentlyDisplayedMonthArray[currentlyDisplayedWeek].count - 1 {
                        if currentlyDisplayedMonthArray[currentlyDisplayedWeek][x] == String(selectedDayInt) {
                            passBackToDaysDelegate.passBackIsSelected(date: selectedDayInt)
                            passBackToNavDelegate.passBackSelectedDay(arraySpot: x)
                        }
                    }
                }
            }
        }
    }
    

}

extension SlideCalendarContainerView : DaysBarDelegate {
    func didSelect(date: Int) {
        for x in Months.allCases {
            if x.name == currentlyDisplayedMonthArray[0][0] {
                guard let inty              = Int(currentlyDisplayedMonthArray[0][1]) else { return }
                selectedDayInt              = date
                selectedMonth               = x
                selectedYear                = inty
                let dateFormatter           = DateFormatter()
                dateFormatter.dateFormat    = "yyyy-M-d"
                selectedDate                = dateFormatter.date(from: "\(inty)-\(x.name)-\(date)")
                monthOffset                 = 0
                delegate.didSelectDate(day: date, month: x, year: inty)
            }
        }
        for x in 0...currentlyDisplayedMonthArray[currentlyDisplayedWeek].count - 1 {
            if currentlyDisplayedMonthArray[currentlyDisplayedWeek][x] == String(date) {
                passBackToNavDelegate.passBackSelectedDay(arraySpot: x)
            }
        }
    }
}


