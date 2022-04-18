//
//  CircularCompassTests.swift
//
//  Created by JechtSh0t on 4/18/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

import XCTest
@testable import BSGCompassKit
import CoreLocation

final class CircularCompassTests: XCTestCase {}

// MARK: - String -

extension CircularCompassTests {
    
    func testString() {
        
        let compassView = CircularCompassView()
        XCTAssertEqual(compassView.getString(from: 100), "100\u{00B0}")
        XCTAssertEqual(compassView.getString(from: 100.0001), "100\u{00B0}")
        XCTAssertEqual(compassView.getString(from: 100.9999), "100\u{00B0}")
    }
}

// MARK: - Heading -

extension CircularCompassTests {
    
    func testDegreeHeading() {
        
        let compass = CircularCompassView()
        
        compass.setHeading(degrees: 180, animated: false)
        XCTAssertEqual(compass.degrees, 180)
        XCTAssertEqual(compass.direction, .south)
        
        compass.setHeading(degrees: 112.5, animated: false)
        XCTAssertEqual(compass.degrees, 112.5)
        XCTAssertEqual(compass.direction, .east)
        
        // This will fail silently, leaving the previous compass heading.
        compass.setHeading(degrees: -100, animated: false)
        XCTAssertEqual(compass.degrees, 112.5)
        XCTAssertEqual(compass.direction, .east)
    }
    
    func testDirectionHeading() {
        
        let compass = CircularCompassView()
        
        compass.setHeading(direction: .north, animated: false)
        XCTAssertEqual(compass.degrees, 0)
        XCTAssertEqual(compass.direction, .north)
        
        compass.setHeading(direction: .east, animated: false)
        XCTAssertEqual(compass.degrees, 90)
        XCTAssertEqual(compass.direction, .east)
        
        compass.setHeading(direction: .northEast, animated: false)
        XCTAssertEqual(compass.degrees, 45)
        XCTAssertEqual(compass.direction, .northEast)
    }
    
    func testDestinationHeading() {
        
        var compass = CircularCompassView()
        
        compass.setHeading(destination: City.miami, origin: City.newYork, animated: false)
        XCTAssertEqual(compass.direction, .south)
        
        compass.setHeading(destination: City.sanDiego, origin: City.newYork, animated: false)
        XCTAssertEqual(compass.direction, .west)
        
        compass.setHeading(destination: City.nashville, origin: City.newYork, animated: false)
        XCTAssertEqual(compass.direction, .west)
        
        compass.setHeading(destination: City.nashville, origin: City.miami, animated: false)
        XCTAssertEqual(compass.direction, .northWest)
    }
}
