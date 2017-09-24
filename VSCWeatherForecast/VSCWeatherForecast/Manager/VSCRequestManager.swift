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

public typealias weatherDownloadError  = (_ error : Error) -> ()
public typealias weatherListDownloadSuccess  = (_ weatherlist : [VSCWeatherItem]) -> ()
public typealias currentweatherDownloadSuccess  = (_ weatherlist : VSCCurrentWeather) -> ()
public typealias weatherIconDownloadSuccess  = (_ weatherIcon : UIImage) -> ()

import UIKit
import Alamofire
import AlamofireImage

class VSCRequestManager: NSObject {
    
    static internal let sharedInstance = VSCRequestManager()
    
    func loadWeatherMap(_ cityName: String, _ nbrOfDate: String, succes: weatherListDownloadSuccess?, error : weatherDownloadError?) {
        let requstUrl = String(format: API_DOWNLAD_WEATHER_URL, arguments: [API_BASE_URL, cityName, nbrOfDate, API_KEY])
        Alamofire.request(requstUrl).responseJSON { response in
            
            if let json = response.result.value {
                
                if  let requestError = VSCJsonParser.parseJsonErrorRequest(response: json) {
                    if let error = error {
                        error(requestError)
                    }
                    return
                }
                
                VSCJsonPersistor.setObject(value: json, key: JSON_PERSISTOR_LIST_WEATHE_KEY)
                let weatherItemList = VSCJsonParser.parseJSONForecastWeatherResponse(response: json)
                if let succes = succes {
                    succes(weatherItemList)
                }
            }
            
            if let json = response.result.error {
                if let error = error {
                    error(json)
                }
            }
        }
    }
    
    func loadIconWeatherMap(_ IconId: String, success : weatherIconDownloadSuccess?, error : weatherDownloadError?) {
        let requstUrl = String(format: API_DOWNLOAD_ICON_URL, arguments: [API_BASE_URL, IconId])
        Alamofire.request(requstUrl).responseImage { response in

            if let image = response.result.value {
                
                if  let requestError = VSCJsonParser.parseJsonErrorRequest(response: image) {
                    if let error = error {
                        error(requestError)
                    }
                    return
                }
                
                if let success  = success {
                    success(image)
                }
            }
            
            if let json = response.result.error {
                if let error = error {
                    error(json)
                }
            }
        }
    }
    
    func loadCurrentWeather(_ cityName: String , success: currentweatherDownloadSuccess?, error : weatherDownloadError?) {
        let requstUrl = String(format: API_API_DOWNALOD_CURRENT_WEATHER, arguments: [API_BASE_URL, cityName, API_KEY])
        Alamofire.request(requstUrl).responseJSON { response in
        
            if let json = response.result.value {
                if  let requestError = VSCJsonParser.parseJsonErrorRequest(response: json) {
                    if let error = error {
                        error(requestError)
                    }
                    return
                }
                
                VSCJsonPersistor.setObject(value: json, key: JSON_PERSISTOR_CURRENT_WEATHE_KEY)
                let weatherItemList = VSCJsonParser.parseJSONCurrentWeatherResponse(response: json)
                if let success = success {
                    success(weatherItemList)
                }
            }
            
            if let json = response.result.error {
                if let error = error {
                    error(json)
                }
            }
        }
    }
    
    func loadCurrentWeatherOffline(success: currentweatherDownloadSuccess?) {
        if let json = VSCJsonPersistor.getObject(key: JSON_PERSISTOR_CURRENT_WEATHE_KEY) {
            let weatherItemList = VSCJsonParser.parseJSONCurrentWeatherResponse(response: json)
            if let success = success {
                success(weatherItemList)
            }
        }
    }
    func loadWeatherListOffline(success: weatherListDownloadSuccess?) {
        if let json = VSCJsonPersistor.getObject(key: JSON_PERSISTOR_LIST_WEATHE_KEY) {
            let weatherItemList = VSCJsonParser.parseJSONForecastWeatherResponse(response: json)
            if let succes = success {
                succes(weatherItemList)
            }
        }
    }

}


class Connectivity {
    class func isConnectedToInternet() ->Bool {
        //weatherListreturn NetworkReachabilityManager()!.isReachable
        return true
    }
}




