//
//  WeatherListPresenter.swift
//  VSCWeatherMap
//
//  Created by Mohamed Marouane YOUSSEF on 24/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import UIKit
import CoreLocation

class VSCWeatherListPresenter: NSObject , LocationServiceDelegate {
    
    weak private var view : WeatherLisProtocol?
    fileprivate var locationService: VSCLocationManager
    
    init(view : WeatherLisProtocol) {
        self.view = view
        locationService = VSCLocationManager()
    }
    
    func loadWeatherForecastData(_ location: CLLocation?) {

        guard let location = location else{
            VSCRequestManager.sharedInstance.loadForecastWeatherOffline(success: { (list) in
                self.view?.refreshView(list)
            })
            return
        }

        guard Connectivity.isConnectedToInternet() else {
            self.view?.showReachbilityALert()
            return
        }
        
        self.view?.startLoading()
        VSCRequestManager.sharedInstance.loadForecastWeatherFromLocation(location, success: { [weak self] (list) in
            self?.view?.finishLoading()
            self?.view?.refreshView(list)
        }) {[weak self] (error) in
            self?.view?.finishLoading()
            self?.view?.showDownlaodErrorAlert(error: error)
        }
    }
    
    func loadCurrentWeatherData(_ location: CLLocation?) {
       
        guard let location = location else{
            VSCRequestManager.sharedInstance.loadCurrentWeatherOffline(success: { (currentWeather) in
                self.view?.refreshView(currentWeather)
            })
            return
        }

        guard Connectivity.isConnectedToInternet() else {
            self.view?.showReachbilityALert()
            return
        }
        
        self.view?.startLoading()
        VSCRequestManager.sharedInstance.loadCurrentrWeatherFromLocation(location, success: { [weak self] (current) in
            self?.view?.finishLoading()
            self?.view?.refreshView(current)
        }) {[weak self] (error) in
            self?.view?.finishLoading()
            self?.view?.showDownlaodErrorAlert(error: error)
        }
    }
    
    func loadWeatherData()  {
        startLocationService()
        loadWeatherForecastData(nil)
        loadCurrentWeatherData(nil)
    }
    
    func startLocationService() {
        locationService.delegate = self
        locationService.requestLocation()
    }
    
    func locationDidUpdate(_ service: VSCLocationManager, location: CLLocation) {
        loadWeatherForecastData(location)
        loadCurrentWeatherData(location)
    }
    
}

