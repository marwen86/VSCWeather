//
//  TodayViewController.swift
//  VSCWeather Widget
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreLocation

class TodayViewController: UIViewController, NCWidgetProviding , LocationServiceDelegate{
    
    @IBOutlet weak var currentWeatherView: VSCCurrentWeatherTableViewCell!
    fileprivate var locationService: VSCLocationManager =  VSCLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
         locationService.delegate = self
         locationService.requestLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    func locationDidUpdate(_ service: VSCLocationManager, location: CLLocation) {
        VSCRequestManager.sharedInstance.loadCurrentrWeatherFromLocation(location, success: {[weak self] (currentWeather) in
             self?.currentWeatherView.weatherItem = currentWeather
        }) { (error) in
            //alert error
        }
    }
    
}
