//
//  VSCDateExtentionTest.swift
//  VSCWeatherForecast
//
//  Created by Mohamed Marouane YOUSSEF on 26/09/2017.
//  Copyright © 2017 Mohamed Marouane YOUSSEF. All rights reserved.
//

import XCTest
@testable import VSCWeatherForecast

class VSCDateExtentionTest: XCTestCase {

    func test_dateToString() {
    
        let dateStr = "lundi 25 septembre"
        let date = dateStr.toDate()
        let transformeDate = date?.toString()
        let calendar = Calendar.current
        let day = String(calendar.component(.day, from: date!))
        
        XCTAssertEqual(transformeDate, dateStr)
        XCTAssertEqual(day,"25")
    }
}
