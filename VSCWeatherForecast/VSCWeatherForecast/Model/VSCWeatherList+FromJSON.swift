//
//  weatherListFromJSON.swift
//  VSCWeatherMap
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

extension VSCWeatherItem {
     static func fromJson(_ weatherData : NSDictionary)->VSCWeatherItem {
        var weatherItem = VSCWeatherItem()
        if let clouds = weatherData["clouds"] as? Int {
            weatherItem.clouds = clouds
        }
        if let deg = weatherData["deg"] as? Int {
            weatherItem.deg = deg
        }
        if let dt = weatherData["dt"] as? Int {
            weatherItem.timeStamp = dt
        }
        if let humidity = weatherData["humidity"] as? Int {
            weatherItem.humidity = humidity
        }
        if let pressure = weatherData["pressure"] as? Double {
            weatherItem.pressure = pressure
        }
        if let speed = weatherData["speed"] as? Double {
            weatherItem.speed = speed
        }
        
        if let temp = weatherData["temp"] as? NSDictionary{
            weatherItem.temp = VSCWeatherTemp.fromJson(temp)
        }
        
        if let weather = weatherData["weather"] as? [AnyObject] , let weatherObject = weather.first as? NSDictionary
        {
            weatherItem.weather = VSCWeatherDescription.fromJson(weatherObject)
        }
        return weatherItem
    }
}
