//
//  VSCweatherRow.swift
//  VSCWeatherForecast
//
//  Created by Mohamed Marouane YOUSSEF on 25/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit
import WatchKit
class VSCweatherRow: NSObject {
    
    @IBOutlet var weatherTemp: WKInterfaceLabel!
    @IBOutlet var weatherDate: WKInterfaceLabel!
    @IBOutlet var weatherIcon: WKInterfaceImage!
    
    var weatherItem : VSCWeatherItem? {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let weatherItem = weatherItem {
            let timeStamp  = weatherItem.timeStamp
            let date = Date(timeIntervalSince1970: Double(timeStamp))
            weatherDate.setText(date.toSimpleDateString())
            
            let temp = weatherItem.temp
            let tempDay = temp.tempDay
            weatherTemp.setText(String(describing: Int(tempDay)) + "°")
            
            let weather = weatherItem.weather
            let iconName = weather.weatherIcon
            VSCRequestManager.sharedInstance.loadIconWeatherMap(iconName, success: { (icon) in
                self.weatherIcon.setImage(icon)
            }, error: { (error) in
                
            })
        }
        
    }
}
