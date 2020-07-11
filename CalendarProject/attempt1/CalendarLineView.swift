//
//  CalendarLineView.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 5/27/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class CalendarLineView: UIView {
    
    var label1  = UILabel()
    var label2  = UILabel()
    var label3  = UILabel()
    var label4  = UILabel()
    var label5  = UILabel()
    var label6  = UILabel()
    var label7  = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 0
        
        label1.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        label3.translatesAutoresizingMaskIntoConstraints = false
        label4.translatesAutoresizingMaskIntoConstraints = false
        label5.translatesAutoresizingMaskIntoConstraints = false
        label6.translatesAutoresizingMaskIntoConstraints = false
        label7.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label1)
        addSubview(label2)
        addSubview(label3)
        addSubview(label4)
        addSubview(label5)
        addSubview(label6)
        addSubview(label7)
        
        NSLayoutConstraint.activate([
            label1.heightAnchor.constraint(equalToConstant: 40),
            label1.widthAnchor.constraint(equalToConstant: 40),
            label1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label1.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            label2.heightAnchor.constraint(equalToConstant: 40),
            label2.widthAnchor.constraint(equalToConstant: 40),
            label2.leadingAnchor.constraint(equalTo: label1.trailingAnchor),
            label2.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            label3.heightAnchor.constraint(equalToConstant: 40),
            label3.widthAnchor.constraint(equalToConstant: 40),
            label3.leadingAnchor.constraint(equalTo: label2.trailingAnchor),
            label3.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            label4.heightAnchor.constraint(equalToConstant: 40),
            label4.widthAnchor.constraint(equalToConstant: 40),
            label4.leadingAnchor.constraint(equalTo: label3.trailingAnchor),
            label4.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            label5.heightAnchor.constraint(equalToConstant: 40),
            label5.widthAnchor.constraint(equalToConstant: 40),
            label5.leadingAnchor.constraint(equalTo: label4.trailingAnchor),
            label5.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            label6.heightAnchor.constraint(equalToConstant: 40),
            label6.widthAnchor.constraint(equalToConstant: 40),
            label6.leadingAnchor.constraint(equalTo: label5.trailingAnchor),
            label6.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            label7.heightAnchor.constraint(equalToConstant: 40),
            label7.widthAnchor.constraint(equalToConstant: 40),
            label7.leadingAnchor.constraint(equalTo: label6.trailingAnchor),
            label7.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            
        ])
    }
}
