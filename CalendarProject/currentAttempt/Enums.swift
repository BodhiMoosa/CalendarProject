//
//  Enums.swift
//  CalendarProject
//
//  Created by Tayler Moosa on 6/28/20.
//  Copyright © 2020 Tayler Moosa. All rights reserved.
//

import UIKit

enum Days : Int, CaseIterable  {
    case Sunday     = 0
    case Monday     = 1
    case Tuesday    = 2
    case Wednesday  = 3
    case Thursday   = 4
    case Friday     = 5
    case Saturday   = 6
    case none       = 7
    
    
}

enum Months : Int, CaseIterable {
    case January        = 1
    case February       = 2
    case March          = 3
    case April          = 4
    case May            = 5
    case June           = 6
    case July           = 7
    case August         = 8
    case September      = 9
    case October        = 10
    case November       = 11
    case December       = 12
    
    var name: String {
      return String(describing: self)
    }
}


