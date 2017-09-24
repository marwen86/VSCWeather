//
//  VSCRequestManager.swift
//  VSCWeatherMap
//
//  Created by Mohamed Marouane YOUSSEF on 23/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

let API_KEY = "b1938b15024d33334163ef66c06849aa"
let API_BASE_URL = "http://api.openweathermap.org"
let API_DOWNLOAD_ICON_URL  = "%@/img/w/%@"
let API_DOWNLAD_WEATHER_URL = "%@/data/2.5/forecast/daily?q=%@&mode=Json&units=metric&cnt=%@&lang=fr&appid=%@"
let API_API_DOWNALOD_CURRENT_WEATHER = "%@/data/2.5/weather?q=%@&mode=Json&units=metric&lang=fr&appid=%@"


public typealias weatherListDownloadSuccess  = (_ weatherlist : [VSCWeatherItem]) -> ()
public typealias currentweatherDownloadSuccess  = (_ weatherlist : VSCCurrentWeather) -> ()
public typealias weatherIconDownloadSuccess  = (_ weatherIcon : UIImage) -> ()

import UIKit
import Alamofire
import AlamofireImage

class VSCRequestManager: NSObject {
    
    static internal let sharedInstance = VSCRequestManager()
    
    func loadWeatherMap(_ cityName: String, _ nbrOfDate: String , succes: weatherListDownloadSuccess?) {
        let requstUrl = String(format: API_DOWNLAD_WEATHER_URL, arguments: [API_BASE_URL, cityName, nbrOfDate, API_KEY])
        Alamofire.request(requstUrl).responseJSON { response in
            
            if let json = response.result.value {
                
                let weatherItemList = VSCRequestManager.sharedInstance.parseJSONForecastWeatherResponse(response: json)
                if let succes = succes {
                    succes(weatherItemList)
                }
            }
        }
    }
    
    func loadIconWeatherMap(_ IconId: String, success : weatherIconDownloadSuccess?) {
        let requstUrl = String(format: API_DOWNLOAD_ICON_URL, arguments: [API_BASE_URL, IconId])
        Alamofire.request(requstUrl).responseImage { response in

            if let image = response.result.value {
                if let success  = success {
                    success(image)
                }
            }
        }
    }
    
    func loadCurrentWeather(_ cityName: String , success: currentweatherDownloadSuccess?) {
        
        let requstUrl = String(format: API_API_DOWNALOD_CURRENT_WEATHER, arguments: [API_BASE_URL, cityName, API_KEY])
        Alamofire.request(requstUrl).responseJSON { response in
            
            if let json = response.result.value {
                
                let weatherItemList = VSCRequestManager.sharedInstance.parseJSONCurrentWeatherResponse(response: json)
                if let success = success {
                    success(weatherItemList)
                }
            }
        }
    }
    
    
    
    func parseJSONCurrentWeatherResponse(response: Any?)-> VSCCurrentWeather {
        var weatherItem = VSCCurrentWeather()
        if let response = response as? NSDictionary{
              weatherItem = VSCCurrentWeather.fromJson(response)
        }
        return  weatherItem
    }
    
    func parseJSONForecastWeatherResponse(response: Any?)-> [VSCWeatherItem] {
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
}



