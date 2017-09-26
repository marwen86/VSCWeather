//
//  VSCRequestManager.swift
//  VSCWeatherMap
//
//  Created by Mohamed Marouane YOUSSEF on 23/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

let API_FORECAST_WEATHER_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"
let API_CURRENT_WEATHER_URL = "http://api.openweathermap.org//data/2.5/weather?"
let API_KEY = "b1938b15024d33334163ef66c06849aa"
let API_DOWNLOAD_ICON_URL  = "http://openweathermap.org/img/w/%@"

public typealias weatherDownloadError  = (_ error : Error) -> ()
public typealias weatherListDownloadSuccess  = (_ weatherlist : [VSCWeatherItem]?) -> ()
public typealias currentweatherDownloadSuccess  = (_ weatherlist : VSCCurrentWeather?) -> ()
public typealias weatherIconDownloadSuccess  = (_ weatherIcon : UIImage) -> ()

import UIKit
import Alamofire
import AlamofireImage
import CoreLocation

class VSCRequestManager: NSObject {
    
    static internal let sharedInstance = VSCRequestManager()
    
    func loadIconWeatherMap(_ IconId: String, success : weatherIconDownloadSuccess?, error : weatherDownloadError?) {
        let requstUrl = String(format: API_DOWNLOAD_ICON_URL, arguments: [IconId])+".png"
        Alamofire.request(requstUrl).responseImage { response in

            switch response.result {
            case .success :
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
                break
            case .failure:
                if let json = response.result.error {
                    if let error = error {
                        error(json)
                    }
                }
                break
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
    func loadForecastWeatherOffline(success: weatherListDownloadSuccess?) {
        if let json = VSCJsonPersistor.getObject(key: JSON_PERSISTOR_LIST_WEATHE_KEY) {
            let weatherItemList = VSCJsonParser.parseJSONForecastWeatherResponse(response: json)
            if let succes = success {
                succes(weatherItemList)
            }
        }
    }
    
    func loadForecastWeatherFromLocation(_ location: CLLocation, success: weatherListDownloadSuccess?, error : weatherDownloadError?) {
        guard let requstUrl = VSCRequestManager.generateWeatherRequestURL(location, cnt: "16") else {
           return
        }
        Alamofire.request(requstUrl).responseJSON { response in
            
            switch response.result {
            case .success :
                if let json = response.result.value {
                    
                    if  let requestError = VSCJsonParser.parseJsonErrorRequest(response: json) {
                        if let error = error {
                            error(requestError)
                        }
                        return
                    }
                    
                    VSCJsonPersistor.setObject(value: json, key: JSON_PERSISTOR_LIST_WEATHE_KEY)
                    let weatherItemList = VSCJsonParser.parseJSONForecastWeatherResponse(response: json)
                    if let succes = success {
                        succes(weatherItemList)
                    }
                }
                break
            case .failure:
                if let json = response.result.error {
                    if let error = error {
                        error(json)
                    }
                }
                break
            }
        }
    }
    
    func loadCurrentrWeatherFromLocation(_ location: CLLocation, success: currentweatherDownloadSuccess?, error : weatherDownloadError?) {
        guard let requstUrl = VSCRequestManager.generateCurrentWeatherRequestURL(location) else {
            return
        }
        Alamofire.request(requstUrl).responseJSON { response in
            
            switch response.result {
            case .success :
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
                break
            case .failure:
                if let json = response.result.error {
                    if let error = error {
                        error(json)
                    }
                }
                break
            }
        }
    }
    
    class func generateWeatherRequestURL(_ location: CLLocation, cnt:String) -> URL? {
        guard var components = URLComponents(string:API_FORECAST_WEATHER_URL) else {
            return nil
        }
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        components.queryItems = [URLQueryItem(name:"lat", value:latitude),
        URLQueryItem(name:"lon", value:longitude),
        URLQueryItem(name:"mode", value:"Json"),
        URLQueryItem(name:"units", value:"metric"),
        URLQueryItem(name:"cnt", value:cnt),
        URLQueryItem(name:"lang", value:"fr"),
        URLQueryItem(name:"appid", value:API_KEY)]
        
        return components.url
    }
    
    class func generateCurrentWeatherRequestURL(_ location: CLLocation) -> URL? {
        guard var components = URLComponents(string:API_CURRENT_WEATHER_URL) else {
            return nil
        }
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        components.queryItems = [URLQueryItem(name:"lat", value:latitude),
                                 URLQueryItem(name:"lon", value:longitude),
                                 URLQueryItem(name:"mode", value:"Json"),
                                 URLQueryItem(name:"units", value:"metric"),
                                 URLQueryItem(name:"lang", value:"fr"),
                                 URLQueryItem(name:"appid", value:API_KEY)]
        
        return components.url
    }
    
    class func generateIconUrlPath(_ IconId : String) -> URL{
        let urlStr = String(format: API_DOWNLOAD_ICON_URL, arguments: [IconId]) + ".png"
        return URL(string: urlStr)!
    }

}


class Connectivity {
    class func isConnectedToInternet() ->Bool {       
        #if os(iOS)
            guard let manager = NetworkReachabilityManager() else{
                return false
            }
            return manager.isReachable
        #else
            return true
        #endif
    }
}
