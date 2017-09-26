//
//  weatherListFromJSON.swift
//  VSCWeatherMap
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

extension VSCWeatherItem {
    static func fromJson(_ weatherData : NSDictionary)-> [VSCWeatherItem]? {
        
        
        guard let city = weatherData["city"] as? NSDictionary,
            let cityName = city["name"] as? String,
            let list = weatherData["list"] as? NSArray else {
            return nil
        }
       
        
        var weatherList = [VSCWeatherItem]()
        for item in list {
            guard let itemDict = item as? NSDictionary,
                let clouds = itemDict["clouds"] as? Int,
                let deg = itemDict["deg"] as? Int,
                let dt = itemDict["dt"] as? Int,
                let humidity = itemDict["humidity"] as? Int,
                let pressure = itemDict["pressure"] as? Double,
                let speed = itemDict["speed"] as? Double,
                let temp = itemDict["temp"] as? NSDictionary,
                let weatherItemTemp = VSCWeatherTemp.fromJson(temp),
                let weather = itemDict["weather"] as? [AnyObject],
                let weatherObject = weather.first as? NSDictionary,
                let weatherItemDesc = VSCWeatherDescription.fromJson(weatherObject) else {
                    
                    break
            }
            weatherList.append(VSCWeatherItem(cityName:cityName, timeStamp: dt, pressure: pressure, humidity: humidity, speed: speed, deg: deg, clouds: clouds, temp: weatherItemTemp, weather: weatherItemDesc))
        }
        return weatherList
    }
}
