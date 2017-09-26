//
//  WeatherItem.swift
//  VSCWeatherMap
//
//  Created by Mohamed Marouane YOUSSEF on 23/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

public struct  VSCWeatherItem {
    
    var timeStamp : Int
    var pressure :Double
    var humidity : Int
    var speed : Double
    var deg : Int
    var clouds : Int
    var temp : VSCWeatherTemp
    var weather : VSCWeatherDescription
}
