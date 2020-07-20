//
//  SlidingCalendarVC.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 7/13/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class SlidingCalendarVC : UIViewController {
    
    let slideCalendar   = SlideCalendarContainerView()
    var testButton      = CustomButton()
    
    override func viewDidLoad() {
        view.backgroundColor                    = .red
        super.viewDidLoad()
        view.addSubview(slideCalendar)
        slideCalendar.delegate                  = self
        
        
        // MARK: Available customization

        slideCalendar.setBorderSides                = [.top, .bottom]
        slideCalendar.setBorderColor                = .systemGray
        slideCalendar.borderWidth                   = 2
        slideCalendar.monthLabelColor               = .label
        
        slideCalendar.calendarNavBarBackgroundColor = .systemBackground
        slideCalendar.calendarNavBarSelectedColor   = .systemPink
        slideCalendar.calendarNavBarDaysTextColor   = .label

        slideCalendar.calendarDaysTextColor         = .label
        slideCalendar.calendarDaysBackgroundColor   = .systemBackground
        slideCalendar.calendarDaysSelectedTextColor = .systemBackground
        slideCalendar.calendarSelectedHighlightColor = .systemPink
        
        NSLayoutConstraint.activate([
            slideCalendar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            slideCalendar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            slideCalendar.heightAnchor.constraint(equalToConstant: 120),
            slideCalendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        configureTestButton()
    }
    
    private func configureTestButton() {
        view.addSubview(testButton)
        NSLayoutConstraint.activate([
            testButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            testButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            testButton.heightAnchor.constraint(equalToConstant: 50),
            testButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        testButton.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
    }
    
    @objc func buttonPress() {
        slideCalendar.shiftWeeks(direction: .left)


    }
    
}

extension SlidingCalendarVC : SlidingCalendarDelegate {
    func didSelectDate(day: Int, month: Months, year: Int) {
        print(day)
        print(month.name)
        print(year)
    }
    
    
}

