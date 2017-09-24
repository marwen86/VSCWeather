//
//  extention.swift
//  VSCWeatherMap
//
//  Created by Mohamed Marouane YOUSSEF on 23/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

extension Date {

    func toString()-> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "FR-fr")
        formatter.dateFormat = "EEEE d MMMM"
        let dateStr = formatter.string(from: self)
        return dateStr
    }
    
    func toSimpleDateString()-> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "FR-fr")
        formatter.dateFormat = "EEEE d"
        let dateStr = formatter.string(from: self)
        return dateStr
    }
}
