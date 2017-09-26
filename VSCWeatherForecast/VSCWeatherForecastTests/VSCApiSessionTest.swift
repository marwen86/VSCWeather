//
//  VSCAPiSessionTest.swift
//  VSCWeatherForecast
//
//  Created by Mohamed Marouane YOUSSEF on 25/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//
import XCTest
import Alamofire
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
    
    func test_CheckThatTheNetworkResponseIsEqualToTheExpectedResult() {
        
        let expectations = expectation(description: "The Response result match the expected results")
        let requstUrlStr = String(format: API_DOWNLAD_WEATHER_URL, arguments: [API_BASE_URL, "paris", "1", API_KEY])
        if let requestUrl = URL(string: requstUrlStr) {
            
            let request = Alamofire.request(requestUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            request.responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    XCTAssertNotNil(response.result.value)
                    XCTAssertNil(response.result.error)
                    expectations.fulfill()
                case .failure(let error):
                    //this is failed case
                    XCTFail("Server response failed : \(error.localizedDescription)")
                    expectations.fulfill()
                }
            })
            
            //wait for some time for the expectation (you can wait here more than 30 sec, depending on the time for the response)
            waitForExpectations(timeout: 30, handler: { (error) in
                if let error = error {
                    print("Failed : \(error.localizedDescription)")
                }
            })
        }
        
    }
}
