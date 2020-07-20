//
//  CalendarControlView.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 7/2/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

enum TapOptions {
    case left
    case center
    case right
}

protocol CalendarNavBarDelegate : class {
    func tapHandler(wasTapped: TapOptions)
        }


class CalendarControlView: UIView {
    
    let rightArrow      = UIImageView(image: Constants.rightArrowImage)
    let leftArrow       = UIImageView(image: Constants.lefArrowImage)
    let monthLabel      = UILabel()
    weak var delegate   : CalendarNavBarDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor                                         = .systemBackground
        translatesAutoresizingMaskIntoConstraints               = false
        rightArrow.translatesAutoresizingMaskIntoConstraints    = false
        leftArrow.translatesAutoresizingMaskIntoConstraints     = false
        monthLabel.translatesAutoresizingMaskIntoConstraints    = false
        monthLabel.textAlignment                                = .center
        monthLabel.layer.borderWidth                            = 1
        monthLabel.layer.borderColor                            = UIColor.systemGray.cgColor
        addSubview(monthLabel)
        addSubview(rightArrow)
        addSubview(leftArrow)
        leftArrow.isUserInteractionEnabled  = true
        monthLabel.isUserInteractionEnabled = true
        rightArrow.isUserInteractionEnabled = true
        leftArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapLeftArrow)))
        monthLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapMonthLabel)))
        rightArrow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapRightArrow)))
        
        
        NSLayoutConstraint.activate([
            leftArrow.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            leftArrow.heightAnchor.constraint(equalToConstant: 30),
            leftArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            leftArrow.widthAnchor.constraint(equalToConstant: 30),
    
            
            rightArrow.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            rightArrow.heightAnchor.constraint(equalToConstant: 30),
            rightArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rightArrow.widthAnchor.constraint(equalToConstant: 30),
            
            monthLabel.leadingAnchor.constraint(equalTo: leftArrow.trailingAnchor),
            monthLabel.trailingAnchor.constraint(equalTo: rightArrow.leadingAnchor),
            monthLabel.heightAnchor.constraint(equalToConstant: 30),
            monthLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
    }
    
    @objc private func tapLeftArrow() {
        delegate.tapHandler(wasTapped: .left)
        
    }
    
    @objc private func tapRightArrow() {
        delegate.tapHandler(wasTapped: .right)
        
    }
    
    @objc private func tapMonthLabel() {
        delegate.tapHandler(wasTapped: .center)
        
    }
}
