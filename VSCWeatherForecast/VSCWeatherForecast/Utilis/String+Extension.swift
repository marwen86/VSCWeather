//
//  String+Extension.swift
//  VSCWeatherForecast
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit
extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }
    
    func toDate() -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "FR-fr")
        formatter.dateFormat = "EEEE d MMMM"
        let date = formatter.date(from: self)
        return date
    }
    
    func toSimpleDate() -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "FR-fr")
        formatter.dateFormat = "EEEE d"
        let date = formatter.date(from: self)
        return date
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

