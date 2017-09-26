//
//  InterfaceController.swift
//  weatherForecast Watch Extension
//
//  Created by Mohamed Marouane YOUSSEF on 25/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation

class InterfaceController: WKInterfaceController, LocationServiceDelegate{
 
    @IBOutlet weak var tableView: WKInterfaceTable!
    var weatherList : [VSCWeatherItem]?
    fileprivate var locationService: VSCLocationManager =  VSCLocationManager()
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        locationService.delegate = self
        locationService.requestLocation()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func loadWeatherForecastData() {

    }
    
    func refreshWiew() {
        if let weatherList = weatherList {
            tableView.setNumberOfRows(weatherList.count, withRowType: "VSCweatherRow")
            for i in (0..<weatherList.count)
            {
                if let row = tableView.rowController(at: i) as? VSCweatherRow {
                    row.weatherItem =  weatherList[i]
                }
            }
        }
    }
    
    func locationDidUpdate(_ service: VSCLocationManager, location: CLLocation) {
        VSCRequestManager.sharedInstance.loadForecastWeatherFromLocation(location, success: {[weak self] (weatherList) in
            self?.weatherList = weatherList
            self?.refreshWiew()
        }) { (error) in
            
        }
    }

}
