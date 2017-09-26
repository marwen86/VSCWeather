//
//  VSCAPiSessionTest.swift
//  VSCWeatherForecast
//
//  Created by Mohamed Marouane YOUSSEF on 25/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//
import XCTest
import Alamofire
import CoreLocation
@testable import VSCWeatherForecast

class VSCApiSessionTest: XCTestCase {
    
    func testWeatherList_thatURLCorrect() {
        let myLocation = CLLocation(latitude: 48.892068, longitude: 2.23516)
        let requstUrl = VSCRequestManager.generateWeatherRequestURL(myLocation, cnt: "16")
        XCTAssertEqual(requstUrl?.absoluteString,"http://api.openweathermap.org/data/2.5/forecast/daily?lat=48.892068&lon=2.23516&mode=Json&units=metric&cnt=16&lang=fr&appid=b1938b15024d33334163ef66c06849aa")
    }
    
    func testCurrentWeather_thatURLCorrect() {
       let myLocation = CLLocation(latitude: 48.892068, longitude: 2.23516)
       let requstUrl = VSCRequestManager.generateCurrentWeatherRequestURL(myLocation)
        XCTAssertEqual(requstUrl?.absoluteString, "http://api.openweathermap.org//data/2.5/weather?lat=48.892068&lon=2.23516&mode=Json&units=metric&lang=fr&appid=b1938b15024d33334163ef66c06849aa")
    }
    
    func testValidResponseNetworkWithValidurl() {
        
        let expectations = expectation(description: "The Response result match the expected results")
        let myLocation = CLLocation(latitude: 48.892068, longitude: 2.23516)
        if let requestUrl = VSCRequestManager.generateWeatherRequestURL(myLocation, cnt: "16") {
        
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
