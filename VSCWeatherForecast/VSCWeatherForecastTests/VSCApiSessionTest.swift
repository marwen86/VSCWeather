//
//  VSCAPiSessionTest.swift
//  VSCWeatherForecast
//
//  Created by Mohamed Marouane YOUSSEF on 25/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//
import XCTest
@testable import VSCWeatherForecast

class VSCApiSessionTest: XCTestCase {
    
    func test_weatherList_thatURLCorrect() {
        let requstUrl = String(format: API_DOWNLAD_WEATHER_URL, arguments: [API_BASE_URL, "paris", "16", API_KEY])
        XCTAssertEqual(requstUrl, "http://api.openweathermap.org/data/2.5/forecast/daily?q=paris&mode=Json&units=metric&cnt=16&lang=fr&appid=b1938b15024d33334163ef66c06849aa")
    }
    
    func test_currentWeather_thatURLCorrect() {
       let requstUrl = String(format: API_API_DOWNALOD_CURRENT_WEATHER, arguments: [API_BASE_URL, "paris", API_KEY])
        XCTAssertEqual(requstUrl, "http://api.openweathermap.org/data/2.5/weather?q=paris&mode=Json&units=metric&lang=fr&appid=b1938b15024d33334163ef66c06849aa")
    }
    
    func test_WeatherIcon_thatURLCorrect() {
       let requstUrl = String(format: API_DOWNLOAD_ICON_URL, arguments: [API_BASE_URL, "03n"])
        XCTAssertEqual(requstUrl, "http://api.openweathermap.org/img/w/03n")
    }
}
