//
//  VSCCurrentWeather+FromJson.swift
//  VSCWeatherForecast
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

extension VSCCurrentWeather {
    static func fromJson(_ weatherData : NSDictionary)-> VSCCurrentWeather? {
        
        
        guard let currentWeatherData = weatherData["main"] as? NSDictionary,
            let humidity = currentWeatherData["humidity"] as? Double,
            
            let pressure = currentWeatherData["pressure"] as? Double,
            let temp_max = currentWeatherData["temp_max"] as? Double,
            let temp_min = currentWeatherData["temp_min"] as? Double,
            let temp = currentWeatherData["temp"] as? Double,
            let weather = weatherData["weather"] as? [AnyObject] ,
            let weatherObject = weather.first as? NSDictionary ,
            let WeatherDescription = VSCWeatherDescription.fromJson(weatherObject) else {
                
                return nil
        }
        return VSCCurrentWeather(humidity: humidity, tempMax: temp_max, tempMin: temp_min, temp: temp, pressure: pressure, weather: WeatherDescription)
    }
}


