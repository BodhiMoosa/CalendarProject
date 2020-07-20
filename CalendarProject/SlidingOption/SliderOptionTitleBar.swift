//
//  SliderOptionTitleBar.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 7/13/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

enum TwoLetterDays : String, CaseIterable {
    case sunday     = "SU"
    case monday     = "MO"
    case tuesday    = "TU"
    case wednesday  = "WE"
    case thursday   = "TH"
    case friday     = "FR"
    case saturday   = "SA"
    
}




class SliderOptionTitleBar: UIView {
    private var selectedDay             : Int?
    private var monthLabel              = UILabel()
    private var daysStackView           = UIStackView()
    
    
    private var labelColor : UIColor = .label {
        didSet {
            let selected = selectedDay ?? 10
            for x in 0...daysStackView.arrangedSubviews.count - 1 {
                guard let y = daysStackView.arrangedSubviews[x] as? UILabel else { return }
                if x == selected {
                    y.textColor = selectedColor
                } else {
                    y.textColor = labelColor
                }
            }
        }
    }
    
    private var selectedColor : UIColor = .systemBlue {
        didSet {
            guard let selectedDay   = selectedDay else { return }
            guard let selected      = daysStackView.arrangedSubviews[selectedDay] as? UILabel else { return }
            selected.textColor      = selectedColor

            
            
        }
    }

    override func didMoveToSuperview() {
        // MARK: Sets delegate from superview
        if let superView = superview as? SlideCalendarContainerView {
            superView.passBackToNavDelegate = self
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        
        configure()
        configureLabelView()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        

        
    }

    private func configureLabelView() {
        monthLabel.translatesAutoresizingMaskIntoConstraints    = false
        monthLabel.textAlignment                                = .center
        monthLabel.text                                         = "Test Month"
        monthLabel.font                                         = monthLabel.font.withSize(25)
        
        addSubview(monthLabel)
        NSLayoutConstraint.activate([
            monthLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            monthLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            monthLabel.topAnchor.constraint(equalTo: self.topAnchor),
            monthLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func configureStackView() {
        daysStackView.translatesAutoresizingMaskIntoConstraints = false
        daysStackView.axis                                      = .horizontal
        daysStackView.distribution                              = .equalSpacing
        daysStackView.alignment                                 = .bottom
            addSubview(daysStackView)
        
        for x in TwoLetterDays.allCases {
            let label                                       = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text                                      = x.rawValue
            label.textAlignment                             = .center
            label.font                                      = label.font.withSize(12)
            daysStackView.addArrangedSubview(label)
            label.widthAnchor.constraint(equalToConstant: 30).isActive  = true
            label.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
        }
        NSLayoutConstraint.activate([
            daysStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            daysStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            daysStackView.topAnchor.constraint(equalTo: self.centerYAnchor),
            daysStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
}

extension SliderOptionTitleBar : PassBackToNavBar {

    func passBackMonthTitleTextColor(color: UIColor) {
        monthLabel.textColor = color
    }
    
    func passBackMonthTitle(month: String) {
        monthLabel.text = month
    }
    
    
    func passBackSelectedDay(arraySpot: Int?) {
        let arraySpot = arraySpot ?? 10
        for x in 0...daysStackView.arrangedSubviews.count - 1 {
            guard let label = daysStackView.arrangedSubviews[x] as? UILabel else { return }
            if x == arraySpot {
                selectedDay     = x
                label.textColor = selectedColor
            } else {
                label.textColor = labelColor
            }
        }
    }
    func passBackBackgroundColor(color: UIColor) {
        backgroundColor = color
    }
    
    func passBackLabelColor(color: UIColor) {
        labelColor = color
    }
    
    func passBackSelectedColor(color: UIColor) {
        selectedColor       = color
        guard let selected  = selectedDay else { return }
        guard let label     = daysStackView.arrangedSubviews[selected] as? UILabel else { return }
        label.textColor     = selectedColor
    }
    
    
}
