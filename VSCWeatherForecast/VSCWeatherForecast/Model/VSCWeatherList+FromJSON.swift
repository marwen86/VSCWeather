//
//  weatherListFromJSON.swift
//  VSCWeatherMap
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

extension VSCWeatherItem {
    static func fromJson(_ weatherData : NSDictionary)-> VSCWeatherItem? {
        
        guard let clouds = weatherData["clouds"] as? Int,
            let deg = weatherData["deg"] as? Int,
            let dt = weatherData["dt"] as? Int,
            let humidity = weatherData["humidity"] as? Int,
            let pressure = weatherData["pressure"] as? Double,
            let speed = weatherData["speed"] as? Double,
            let temp = weatherData["temp"] as? NSDictionary,
            let weatherItemTemp = VSCWeatherTemp.fromJson(temp),
            let weather = weatherData["weather"] as? [AnyObject],
            let weatherObject = weather.first as? NSDictionary,
            let weatherItemDesc = VSCWeatherDescription.fromJson(weatherObject) else {
                
                return nil
        }
        
        return VSCWeatherItem(timeStamp: dt, pressure: pressure, humidity: humidity, speed: speed, deg: deg, clouds: clouds, temp: weatherItemTemp, weather: weatherItemDesc)
    }
}
