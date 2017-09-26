//
//  VSCWeathertemp+FromJSON.swift
//  VSCWeatherMap
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

extension VSCWeatherTemp {
    
    static func fromJson(_ weatherData : NSDictionary)-> VSCWeatherTemp? {
        
        guard let day = weatherData["day"] as? Double,
            let eve = weatherData["eve"] as? Double,
            let max = weatherData["max"] as? Double,
            let min = weatherData["min"] as? Double,
            let morn = weatherData["morn"] as? Double,
            let night = weatherData["night"] as? Double else{
                return nil
        }
        return VSCWeatherTemp(tempDay: day, tempMin: min, tempMax: max, tempNight: night, tempeEve: eve, tempMorn: morn)
    }
}
