//
//  SpeedometerTests.swift
//
//  Created by JechtSh0t on 4/5/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

import XCTest
@testable import BSGCompassKit

final class SpeedometerTests: XCTestCase {
    
    func testString() {
        
        let speedometerView = CircularSpeedometerView()
        XCTAssertEqual(speedometerView.getString(from: 100), "100")
        XCTAssertEqual(speedometerView.getString(from: 100.0001), "100")
        XCTAssertEqual(speedometerView.getString(from: 100.9999), "100")
    }
}
