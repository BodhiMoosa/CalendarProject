//
//  ViewController.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 5/27/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var isOpen = false
    var singleView : CalendarLineView!
    var groupOfViews: [CalendarLineView] = []
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCardsToSlide()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemRed
        singleView = CalendarLineView()
        singleView.label3.text = "test fade"
        view.addSubview(singleView)

        NSLayoutConstraint.activate([
            singleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            singleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            singleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            singleView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Hit Me!", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    @objc private func buttonTap() {
        
        if !isOpen {
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: [.calculationModeLinear], animations: {
                // Add animations
                
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: (1/5)/1) {
                    self.singleView.label3.alpha = 0
                }
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: (1/5)/1, animations: {
                    for x in self.groupOfViews {
                        x.frame.origin.y += 50
                    }
                    self.groupOfViews.removeFirst()
                    
                })
                UIView.addKeyframe(withRelativeStartTime: (1/5)/1, relativeDuration: (1/5)/1, animations: {
                    
                    for x in self.groupOfViews {
                        x.frame.origin.y += 50
                    }
                    self.groupOfViews.removeFirst()
                })
                UIView.addKeyframe(withRelativeStartTime: (2/5)/1, relativeDuration: (1/5)/1, animations: {
                    
                    for x in self.groupOfViews {
                        x.frame.origin.y += 50
                    }
                    self.groupOfViews.removeFirst()
                })
                UIView.addKeyframe(withRelativeStartTime: (3/5)/1, relativeDuration: (1/5)/1, animations: {
                    
                    for x in self.groupOfViews {
                        x.frame.origin.y += 50
                    }
                    self.groupOfViews.removeFirst()
                    
                })
                UIView.addKeyframe(withRelativeStartTime: (4/5)/1, relativeDuration: (1/5)/1, animations: {
                    
                    for x in self.groupOfViews {
                        x.frame.origin.y += 50
                    }
                    self.groupOfViews.removeFirst()
                    
                })
            }, completion:{ _ in
                print("I'm done!")
                self.isOpen = true
                
            })
        } else {
            retract()
            
        }
        

        
    }
    
    private func setUpCardsToSlide() {
        for x in 0...4 {
            let singleExtraViews = CalendarLineView()
            singleExtraViews.tag = x + 10
            singleExtraViews.label1.text = String(1 + (7*x))
            singleExtraViews.label2.text = String(2 + (7*x))
            singleExtraViews.label3.text = String(3 + (7*x))
            singleExtraViews.label4.text = String(4 + (7*x))
            singleExtraViews.label5.text = String(5 + (7*x))
            singleExtraViews.label6.text = String(6 + (7*x))
            singleExtraViews.label7.text = String(7 + (7*x))
            groupOfViews.append(singleExtraViews)
            view.addSubview(singleExtraViews)
            NSLayoutConstraint.activate([
                singleExtraViews.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                singleExtraViews.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                singleExtraViews.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                singleExtraViews.heightAnchor.constraint(equalToConstant: 50)
            ])
            
    
            
            
        }
    }
    
    private func retract() {
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: (1/5)/1) {
                self.view.viewWithTag(14)?.frame.origin.y -= 50
             }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: (1/5)/1) {
               self.view.viewWithTag(14)?.frame.origin.y -= 50
                self.view.viewWithTag(13)?.frame.origin.y -= 50
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: (1/5)/1) {
                self.view.viewWithTag(12)?.frame.origin.y -= 50
                self.view.viewWithTag(14)?.frame.origin.y -= 50
                 self.view.viewWithTag(13)?.frame.origin.y -= 50
             }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: (1/5)/1) {
                self.view.viewWithTag(12)?.frame.origin.y -= 50
                self.view.viewWithTag(14)?.frame.origin.y -= 50
                 self.view.viewWithTag(13)?.frame.origin.y -= 50
                self.view.viewWithTag(11)?.frame.origin.y -= 50
             }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: (1/5)/1) {
                self.view.viewWithTag(10)?.frame.origin.y -= 50
                self.view.viewWithTag(12)?.frame.origin.y -= 50
                self.view.viewWithTag(14)?.frame.origin.y -= 50
                 self.view.viewWithTag(13)?.frame.origin.y -= 50
                self.view.viewWithTag(11)?.frame.origin.y -= 50
             }
        }) { _ in
            print("done")
            self.isOpen = false
        }
    }
}

