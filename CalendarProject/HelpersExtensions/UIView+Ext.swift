//
//  UIView+Ext.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 7/9/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit
enum Sides {
    case top
    case left
    case right
    case bottom
}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func bordered(cornerRadius: CGFloat, color: CGColor, width: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = width
        self.layer.borderColor = color
    }
    
    func borderSides(sides: [Sides], borderColor: UIColor, borderWidth: CGFloat) {
        var tag = 10
        for x in sides {
            let singleBorder                                        = UIView()
            singleBorder.tag                                        = tag
            tag                                                     += 1
            singleBorder.translatesAutoresizingMaskIntoConstraints  = false
            singleBorder.backgroundColor                            = borderColor
            self.superview?.bringSubviewToFront(singleBorder)
            self.addSubview(singleBorder)
            singleBorder.layer.zPosition = 2
            if x == .top || x == .bottom {
                singleBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive             = true
                singleBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive           = true
                singleBorder.heightAnchor.constraint(equalToConstant: borderWidth).isActive                       = true
                if x == .top {
                    singleBorder.topAnchor.constraint(equalTo: self.topAnchor).isActive                 = true
                } else {
                    singleBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive           = true
                }
            } else {
                singleBorder.topAnchor.constraint(equalTo: self.topAnchor).isActive                     = true
                singleBorder.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive               = true
                singleBorder.widthAnchor.constraint(equalToConstant: borderWidth).isActive                        = true
                if x == .left {
                       singleBorder.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive      = true
                   } else {
                       singleBorder.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive    = true
                   }
            }
        }
    }
    
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    
    func findParentView() -> UIView? {
        if let nextResponder = self.next as? UIView {
            return nextResponder
        } else {
            return nil
        }
        
    }
    

}
