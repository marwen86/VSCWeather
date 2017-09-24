//
//  WeatherListPresenter.swift
//  VSCWeatherMap
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit

class VSCWeatherListPresenter: NSObject {

    weak private var view : WeatherLisProtocol?
    
    init(view : WeatherLisProtocol) {
        self.view = view
    }
    
    func loadData() {
        self.view?.startLoading()
        VSCRequestManager.sharedInstance.loadWeatherMap("paris", "16") {[weak self] (weatherList) in
            self?.view?.finishLoading()
            self?.view?.refreshView(weatherList)
        }
    }
}
