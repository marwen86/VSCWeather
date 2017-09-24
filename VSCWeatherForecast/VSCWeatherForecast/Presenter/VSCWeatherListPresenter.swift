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
    
    func loadWeatherForecastData() {
        self.view?.startLoading()
        VSCRequestManager.sharedInstance.loadWeatherMap("paris", "16", succes: {[weak self] (weatherList) in
            self?.view?.finishLoading()
            self?.view?.refreshView(weatherList)
        }) {[weak self] (error) in
            self?.view?.showDownlaodErrorAlert(error: error)
        }
    }
    
    func loadCurrentWeatherData() {
        self.view?.startLoading()
        VSCRequestManager.sharedInstance.loadCurrentWeather("paris", success: { [weak self](currentWeather) in
            self?.view?.refreshView(currentWeather)
        }) {[weak self] (error) in
            self?.view?.showDownlaodErrorAlert(error: error)
        }
    }
    
    func loadWeatherData()  {
        
        guard Connectivity.isConnectedToInternet() else {
            self.view?.showReachbilityALert()
            return
        }
        
        loadWeatherForecastData()
        loadCurrentWeatherData()
    }
    
    
}
