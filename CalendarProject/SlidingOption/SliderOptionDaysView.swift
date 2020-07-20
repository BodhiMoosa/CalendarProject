//
//  SliderOptionDaysView.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 7/13/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

protocol DaysBarDelegate : class {
    func didSelect(date: Int)
        }

class SliderOptionDaysView: UIView {
    
    weak var delegate                       : DaysBarDelegate!
    private var currentDaysArray            : [DaysLabel] = []
    private var daysStackView               = UIStackView()
    
    private var selectedTextColor : UIColor         = .systemBackground {
        didSet {
            for x in currentDaysArray {
                x.selectedTextColor = selectedTextColor
            }
        }
    }
    private var selectedBackgroundColor : UIColor   = .systemPink {
        didSet {
            for x in currentDaysArray {
                x.selectedBackgroundColor = selectedBackgroundColor
            }
        }
    }
    private var daysTextColor : UIColor    = .label {
        didSet {
            for x in currentDaysArray {
                x.unselectedTextColor = daysTextColor
            }
        }
    }
    

    private var height : CGFloat = 30
    
    override func didMoveToSuperview() {
        if let superView = superview as? SlideCalendarContainerView {
            superView.passBackToDaysDelegate = self
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureLabelArray()
        configureStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(datesFromMonToFri : [String]) {
        if datesFromMonToFri.count != 7 {
            return
        }
        for x in 0...currentDaysArray.count - 1 {
            currentDaysArray[x].text = datesFromMonToFri[x]
        }
        
        
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLabelArray() {
        for x in 0...6 {
            currentDaysArray.append(DaysLabel())
            currentDaysArray[x].text                                                        = String(x)
            currentDaysArray[x].widthAnchor.constraint(equalToConstant: height).isActive    = true
            currentDaysArray[x].heightAnchor.constraint(equalToConstant: height).isActive   = true
            currentDaysArray[x].layer.cornerRadius                                          = height / 2
            currentDaysArray[x].clipsToBounds                                               = true
            currentDaysArray[x].isUserInteractionEnabled                                    = true
            currentDaysArray[x].selectedBackgroundColor                                     = selectedBackgroundColor
            currentDaysArray[x].selectedTextColor                                           = selectedTextColor
            currentDaysArray[x].unselectedTextColor                                         = daysTextColor
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(selectDate(sender:)))
            currentDaysArray[x].addGestureRecognizer(tap)
            
            
        }
        
    }
    
    @objc private func selectDate(sender: UITapGestureRecognizer) {
        if let sender = sender.view as? DaysLabel {
            if let inty = Int(sender.text!) {
                delegate.didSelect(date: inty)
                for x in currentDaysArray {
                    if x == sender {
                        x.isSelected    = true
                        x.textColor     = selectedTextColor
                    } else {
                        x.isSelected    = false
                        x.textColor     = daysTextColor
                    }
                }
            }
        }
        
    }
    
    private func configureStackView() {
        daysStackView.translatesAutoresizingMaskIntoConstraints = false
        daysStackView.alignment                                 = .center
        daysStackView.axis                                      = .horizontal
        daysStackView.distribution                              = .equalSpacing
        
        addSubview(daysStackView)
        for x in currentDaysArray {
            daysStackView.addArrangedSubview(x)
        }
        
        NSLayoutConstraint.activate([
            daysStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            daysStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            daysStackView.topAnchor.constraint(equalTo: self.topAnchor),
            daysStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        

    }
    


}

extension SliderOptionDaysView : PassBackToDaysBar {
    func passBackIsSelected(date: Int) {
        for x in currentDaysArray {
            if x.text == String(date) {
                x.isSelected = true
            } else {
                x.isSelected = false
            }
        }
    }
    
    func passBackSelectedDateBackgroundColor(color: UIColor) {
        selectedBackgroundColor = color
    }
    
    func passBackBackgroundColor(color: UIColor) {
        backgroundColor = color
    }
    
    func passBackUnselectedTextColor(color: UIColor) {
        daysTextColor = color
    }
    
    func passBackSelectedTextColor(color: UIColor) {
        selectedTextColor = color
    }
    
    
}
