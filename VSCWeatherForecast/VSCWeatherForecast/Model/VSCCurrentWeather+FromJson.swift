//
//  VSCCurrentWeather+FromJson.swift
//  VSCWeatherForecast
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

extension VSCCurrentWeather {
    static func fromJson(_ weatherData : NSDictionary)->VSCCurrentWeather {
        var weatherItem = VSCCurrentWeather()
       
        if let currentWeatherData = weatherData["main"] as? NSDictionary {
            if let humidity = currentWeatherData["humidity"] as? Double {
                weatherItem.humidity = humidity
            }
            
            if let pressure = currentWeatherData["pressure"] as? Double {
                weatherItem.pressure = pressure
            }
            if let temp_max = currentWeatherData["temp_max"] as? Double {
                weatherItem.tempMax = temp_max
            }
            if let temp_min = currentWeatherData["temp_min"] as? Double {
                weatherItem.tempMin = temp_min
            }
            if let temp = currentWeatherData["temp"] as? Double {
                weatherItem.temp = temp
            }
        }
        
        if let weather = weatherData["weather"] as? [AnyObject] , let weatherObject = weather.first as? NSDictionary
        {
            weatherItem.weather = VSCWeatherDescription.fromJson(weatherObject)
        }
        return weatherItem
    }
}


