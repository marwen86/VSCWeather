//
//  VSCJsonParserTest.swift
//  VSCWeatherForecast
//
//  Created by Mohamed Marouane YOUSSEF on 25/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import XCTest
@testable import VSCWeatherForecast

class VSCJsonParserTest: XCTestCase {
    let sampleJSONResponse: [String: Any] = {
        // hard crash on all of this if something is wrong
        let url = Bundle(for: VSCWeatherForecastTests.self).url(forResource: "sample_response", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    }()
    
    func testWeatherListFromRequestJson() {
        
        let json = sampleJSONResponse
        let weatherItemList = VSCJsonParser.parseJSONForecastWeatherResponse(response: json)!
        XCTAssertTrue(weatherItemList.count == 1 )
    }
    
    func testWeatherItemFromFromRequestJson() {
        
        let json = sampleJSONResponse
        let weatherItemList = VSCJsonParser.parseJSONForecastWeatherResponse(response: json)!
        let weatherItem = weatherItemList.first!
        XCTAssertEqual(weatherItem.timeStamp, 1506337200)
        XCTAssertEqual(weatherItem.pressure, 1019.57)
        XCTAssertEqual(weatherItem.humidity, 74)
        XCTAssertEqual(weatherItem.speed, 1.36)
        XCTAssertEqual(weatherItem.deg, 37)
        XCTAssertEqual(weatherItem.clouds, 36)
    }
    
    func testWeatherTempFromFromRequestJson() {
        
        let json = sampleJSONResponse
        let weatherItemList = VSCJsonParser.parseJSONForecastWeatherResponse(response: json)!
        let weatherItem = weatherItemList.first!
        let weatherTemp = weatherItem.temp
        XCTAssertEqual(weatherTemp.tempDay, 17.43)
        XCTAssertEqual(weatherTemp.tempMin, 12.28)
        XCTAssertEqual(weatherTemp.tempMax, 17.43)
        XCTAssertEqual(weatherTemp.tempNight, 12.28)
        XCTAssertEqual(weatherTemp.tempeEve, 17.43)
        XCTAssertEqual(weatherTemp.tempMorn, 17.43)
    }
    
    func testWeatherDescriptionFromRequestJson() {
        
        let json = sampleJSONResponse
        let weatherItemList = VSCJsonParser.parseJSONForecastWeatherResponse(response: json)!
        let weatherItem = weatherItemList.first!
        let weatherDesc = weatherItem.weather
        XCTAssertEqual(weatherDesc.weatherMain, "Clouds")
        XCTAssertEqual(weatherDesc.weatherDescription, "scattered clouds")
        XCTAssertEqual(weatherDesc.weatherIcon, "03n")
    }
    
    func testWeatherDescriptionJsonParse() {
        let weatherDict: NSDictionary = ["id" : 802,
                                         "main" : "Clouds",
                                         "description" : "scattered clouds",
                                         "icon" : "03n"]
        
        let weatherDescription = VSCWeatherDescription.fromJson(weatherDict)!
        XCTAssertEqual(weatherDescription.weatherMain, "Clouds")
        XCTAssertEqual(weatherDescription.weatherDescription, "scattered clouds")
        XCTAssertEqual(weatherDescription.weatherIcon, "03n")
    }
    
    func testWeatherTempsonParse() {
        let weatherDict: NSDictionary = [    "day" : 17.43,
                                             "min" : 12.28,
                                             "max" : 17.43,
                                             "night" : 12.28,
                                             "eve" : 17.43,
                                             "morn" : 17.43]
        
        let weatherTemp = VSCWeatherTemp.fromJson(weatherDict)!
        XCTAssertEqual(weatherTemp.tempDay, 17.43)
        XCTAssertEqual(weatherTemp.tempMin, 12.28)
        XCTAssertEqual(weatherTemp.tempMax, 17.43)
        XCTAssertEqual(weatherTemp.tempNight, 12.28)
        XCTAssertEqual(weatherTemp.tempeEve, 17.43)
        XCTAssertEqual(weatherTemp.tempMorn, 17.43)
    }
}
