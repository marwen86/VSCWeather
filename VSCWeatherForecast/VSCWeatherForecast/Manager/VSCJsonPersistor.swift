//
//  VSCJsonPersistor.swift
//  VSCWeatherForecast
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

class VSCJsonPersistor: NSObject {

    class func setObject(value:Any ,key:String){
        let pref = UserDefaults.standard
        pref.set(value, forKey: key)
        pref.synchronize()
    }
    
    class func getObject(key:String) -> Any?{
        let pref = UserDefaults.standard
        let value = pref.value(forKey: key)
        return value
    }
}
