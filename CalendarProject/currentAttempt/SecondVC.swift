//
//  SecondVC.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 6/28/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class SecondVC: UIViewController {

    
    
    let button                  = CustomButton()
    let calendarContainerView   = CalendarContainerView()

    private func configure() {
        view.backgroundColor = .systemPink
        
        view.addSubview(calendarContainerView)
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonTouch), for: .touchUpInside)
        NSLayoutConstraint.activate([
            calendarContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendarContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendarContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
    }
    

    
    @objc private func buttonTouch() {
        calendarContainerView.open()
    }


}

