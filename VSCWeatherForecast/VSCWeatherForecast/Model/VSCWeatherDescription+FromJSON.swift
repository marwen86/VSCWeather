//
//  VSCWeatherDescription+FromJSON.swift
//  VSCWeatherMap
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit
extension VSCWeatherDescription {
    
    static func fromJson(_ weatherData : NSDictionary)->VSCWeatherDescription {
        var weatherDescription = VSCWeatherDescription()
        if let description = weatherData["description"] as? String {
            weatherDescription.weatherDescription = description
        }
        if let icon = weatherData["icon"] as? String {
            weatherDescription.weatherIcon = icon
        }
        if let main = weatherData["main"] as? String {
            weatherDescription.weatherMain = main
        }
        return weatherDescription
    }
}
