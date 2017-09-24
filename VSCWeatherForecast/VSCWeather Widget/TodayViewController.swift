//
//  TodayViewController.swift
//  VSCWeather Widget
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit
import NotificationCenter
import Alamofire

class TodayViewController: UIViewController, NCWidgetProviding {
    
    @IBOutlet weak var currentWeatherView: VSCCurrentWeatherTableViewCell!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
         loadCurrentWeatherData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        completionHandler(NCUpdateResult.newData)
    }
    
    func loadCurrentWeatherData() {
        
        VSCRequestManager.sharedInstance.loadCurrentWeather("paris", success: { [weak self](currentWeather) in
            self?.currentWeatherView.weatherItem = currentWeather
        }) {(error) in
            
        }
    }
    
}
