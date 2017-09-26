//
//  VSCWeatherDescription+FromJSON.swift
//  VSCWeatherMap
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit
extension VSCWeatherDescription {
    
    static func fromJson(_ weatherData : NSDictionary)-> VSCWeatherDescription? {
        
        guard let description = weatherData["description"] as? String,
            let icon = weatherData["icon"] as? String,
            let main = weatherData["main"] as? String else {
                return nil
        }
        return VSCWeatherDescription(weatherMain: main, weatherDescription: description, weatherIcon: icon)
    }
}
