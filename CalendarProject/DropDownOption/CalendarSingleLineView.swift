//
//  CalendarSingleLineView.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 6/28/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

protocol CalendarDelegate : class {
    func tapOnLineItem(tag: Int, numSelected: Int)
        }

class CalendarSingleLineView: UIView {
    
    weak var delegate : CalendarDelegate!
    
    var selectedDate : Int?
    
    var heightConstraint        : NSLayoutConstraint!
    var widthConstraint         : NSLayoutConstraint!
    
    var heightConstraintArray   : [NSLayoutConstraint] = []
    var widthConstraintArray    : [NSLayoutConstraint] = []
    
    var horizontalStack         = UIStackView()
    
    var labelArray              : [UILabel] = []
    
    var isCircle                : Bool = true {
        didSet {
            for x in 0...6 {
                labelArray[x].layer.cornerRadius = isCircle ? heightWidth * 0.5 : 0
            }
        }
    }
    
    var isRounded : Bool = false {
        didSet {
            for x in 0...6 {
                labelArray[x].layer.cornerRadius = isRounded ? heightWidth * 0.25 : 0
            }
        }
    }
    
    var heightWidth : CGFloat = 40 {
        didSet {
            updateSquareConstraints(labelArray: labelArray)
        }
    }
    private func updateSquareConstraints(labelArray: [UILabel]) {
        for x in 0...labelArray.count - 1 {
            widthConstraintArray[x].isActive = false
            widthConstraintArray[x] = labelArray[x].widthAnchor.constraint(equalToConstant: heightWidth)
            widthConstraintArray[x].isActive = true
            
            heightConstraintArray[x].isActive = false
            heightConstraintArray[x] = labelArray[x].heightAnchor.constraint(equalToConstant: heightWidth)
            heightConstraintArray[x].isActive = true
        }
    }
    
    private func setSquareConstraints(labelArray: [UILabel]) {
        for x in 0...labelArray.count - 1 {
            widthConstraintArray.append(labelArray[x].widthAnchor.constraint(equalToConstant: heightWidth))
            widthConstraintArray[x].isActive = true
            heightConstraintArray.append(labelArray[x].heightAnchor.constraint(equalToConstant: heightWidth))
            heightConstraintArray[x].isActive = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init(heightWidth: CGFloat) {
        super.init(frame: .zero)
        self.heightWidth = heightWidth
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints                   = false
        horizontalStack.translatesAutoresizingMaskIntoConstraints   = false
        horizontalStack.alignment                                   = .center
        horizontalStack.axis                                        = .horizontal
        horizontalStack.distribution                                = .equalSpacing
        addSubview(horizontalStack)
        
        NSLayoutConstraint.activate([
            horizontalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            horizontalStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            horizontalStack.topAnchor.constraint(equalTo: self.topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        
        for x in 0...6 {
            let tap = UITapGestureRecognizer(target: self, action: #selector(labelTap(sender:)))
            
            labelArray.append(UILabel())
            labelArray[x].translatesAutoresizingMaskIntoConstraints             = false
            labelArray[x].layer.borderWidth                                     = 1
            labelArray[x].clipsToBounds                                         = true
            labelArray[x].layer.borderColor                                     = UIColor.label.cgColor
            labelArray[x].textAlignment                                         = .center
            labelArray[x].backgroundColor                                       = .systemBackground
            labelArray[x].isUserInteractionEnabled                              = true
            labelArray[x].addGestureRecognizer(tap)
            horizontalStack.addArrangedSubview(labelArray[x])
            
        }
        setSquareConstraints(labelArray: labelArray)
    }
    @objc private func labelTap(sender: UITapGestureRecognizer) {
        guard let view          = sender.view as? UILabel else { return }
        guard let number        = Int(view.text!) else { return }
        selectedDate            = number
        delegate.tapOnLineItem(tag: self.tag, numSelected: selectedDate!)
        view.backgroundColor    = .systemGray

        
    }
    func set(bgColor: UIColor, textArray: [String]) {
        var updatedTextArray = textArray
        if textArray.count < 7 {
            for _ in textArray.count...6 {
                updatedTextArray.append(" ")
            }
        }
        backgroundColor = bgColor
        for x in 0...6 {
            labelArray[x].text = updatedTextArray[x]
        }
    }
    
    func cleanUp() {
        for x in labelArray {
            x.backgroundColor = .systemBackground
        }
    }
}
