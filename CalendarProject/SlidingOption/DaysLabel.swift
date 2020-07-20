//
//  DaysLabel.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 7/13/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class DaysLabel: UILabel {
    
    var selectedBackgroundColor : UIColor   = .systemPink {
        didSet {
            if isSelected {
                backgroundColor = selectedBackgroundColor
            }
        }
    }
    var unselectedBackgroundColor : UIColor = .clear {
        didSet {
            if !isSelected {
                backgroundColor = unselectedBackgroundColor
            }
        }
    }
    var selectedTextColor : UIColor         = .systemBackground {
        didSet {
            if isSelected {
                textColor = selectedTextColor
            }
        }
    }
    
    var unselectedTextColor : UIColor       = .label {
        didSet {
            if !isSelected {
                textColor = unselectedTextColor
            }
        }
   
    }
    
    var isSelected = false {
        didSet {
            if isSelected {
                backgroundColor     = selectedBackgroundColor
                layer.borderWidth   = 1
                textColor           = selectedTextColor
            } else {
                backgroundColor     = unselectedBackgroundColor
                layer.borderWidth   = 0
                textColor           = unselectedTextColor
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        textAlignment                               = .center
        layer.borderColor                           = UIColor.systemGray.cgColor
        
        
    
    }
    


}
