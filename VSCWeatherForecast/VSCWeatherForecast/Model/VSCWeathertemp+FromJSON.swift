//
//  VSCWeathertemp+FromJSON.swift
//  VSCWeatherMap
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

extension VSCWeatherTemp {
    
    static func fromJson(_ weatherData : NSDictionary)-> VSCWeatherTemp {
        var weatherTemp = VSCWeatherTemp()
        if let day = weatherData["day"] as? Double {
            weatherTemp.tempDay = day
        }
        if let eve = weatherData["eve"] as? Double {
            weatherTemp.tempeEve = eve
        }
        if let max = weatherData["max"] as? Double {
            weatherTemp.tempMax = max
        }
        if let min = weatherData["min"] as? Double {
            weatherTemp.tempMin = min
        }
        if let morn = weatherData["morn"] as? Double {
            weatherTemp.tempMorn = morn
        }
        if let night = weatherData["night"] as? Double {
            weatherTemp.tempNight = night
        }
        return weatherTemp
    }
}
