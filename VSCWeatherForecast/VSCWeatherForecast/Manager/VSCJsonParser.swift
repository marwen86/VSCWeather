//
//  VSCJsonParser.swift
//  VSCWeatherForecast
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//


import UIKit

let JSON_PERSISTOR_LIST_WEATHE_KEY = "listWeatherForecast"
let JSON_PERSISTOR_CURRENT_WEATHE_KEY = "currentWeather"

class VSCJsonParser: NSObject {

    class func parseJSONCurrentWeatherResponse(response: Any?)-> VSCCurrentWeather? {
        
        guard let response = response as? NSDictionary else {
            return nil
        }
        return  VSCCurrentWeather.fromJson(response)
    }
    
    class func parseJSONForecastWeatherResponse(response: Any?)-> [VSCWeatherItem]? {
       
        guard let response = response as? NSDictionary , let list = response["list"] as? NSArray else {
            return nil
        }
        
        var weatherList = [VSCWeatherItem]()
        for item in list {
            if let item = item as? NSDictionary{
                guard let weatherItem = VSCWeatherItem.fromJson(item) else {
                  break
                }
                weatherList.append(weatherItem)
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
