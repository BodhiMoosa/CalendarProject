//
//  CustomButton.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 7/2/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        backgroundColor                             = .systemBackground
        layer.borderColor                           = UIColor.label.cgColor
        layer.borderWidth                           = 2
        layer.cornerRadius                          = 15
        
        layer.shadowRadius                          = 5
        layer.shadowColor                           = UIColor.systemGray.cgColor
        layer.shadowOffset                          = CGSize(width: 1, height: 3)
        layer.shadowOpacity                         = 0.8
        
        
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(touchUpOutside), for: .touchUpOutside)
    }
    
    @objc private func touchDown() {
        layer.shadowOpacity = 0
        layer.borderWidth   = 1
        
    }
    
    @objc private func touchUpOutside() {
        layer.shadowOpacity = 0.8
        layer.borderWidth   = 2
        
    }
    
    @objc private func touchUpInside() {
        layer.shadowOpacity = 0.8
        layer.borderWidth   = 2

        
    }
}
