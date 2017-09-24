//
//  VSCJsonParser.swift
//  VSCWeatherForecast
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

class VSCJsonParser: NSObject {

    class func parseJSONCurrentWeatherResponse(response: Any?)-> VSCCurrentWeather {
        var weatherItem = VSCCurrentWeather()
        if let response = response as? NSDictionary{
            weatherItem = VSCCurrentWeather.fromJson(response)
        }
        return  weatherItem
    }
    
    class func parseJSONForecastWeatherResponse(response: Any?)-> [VSCWeatherItem] {
        var weatherList = [VSCWeatherItem]()
        if let response = response as? NSDictionary , let list = response["list"] as? NSArray {
            for item in list {
                if let item = item as? NSDictionary{
                    let weatherItem = VSCWeatherItem.fromJson(item)
                    weatherList.append(weatherItem)
                }
            }
        }
        return  weatherList
    }
    
    class func parseJsonErrorRequest(response: Any?) -> Error? {
        if let response = response as? NSDictionary, let code = response["cod"] as? Int, let message = response["message"] as? String{
            let error = NSError(domain: String(describing: VSCRequestManager.self), code: code, userInfo: ["message" : message])
            return error
            }
        return nil
    }
}
