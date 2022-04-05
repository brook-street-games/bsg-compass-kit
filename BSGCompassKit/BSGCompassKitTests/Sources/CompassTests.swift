//
//  CompassTests.swift
//
//  Created by JechtSh0t on 4/3/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

import XCTest
@testable import BSGCompassKit

final class CompassTests: XCTestCase {
    
    func testString() {
        
        let compassView = CircularCompassView()
        XCTAssertEqual(compassView.getString(from: 100), "100\u{00B0}")
        XCTAssertEqual(compassView.getString(from: 100.0001), "100\u{00B0}")
        XCTAssertEqual(compassView.getString(from: 100.9999), "100\u{00B0}")
    }
}
