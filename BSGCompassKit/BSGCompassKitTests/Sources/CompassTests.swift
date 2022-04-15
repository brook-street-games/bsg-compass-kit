//
//  CompassTests.swift
//
//  Created by JechtSh0t on 4/3/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

import XCTest
@testable import BSGCompassKit
import CoreLocation

final class CompassTests: XCTestCase {
    
    let newYork = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)
    let sanDiego = CLLocationCoordinate2D(latitude: 32.7157, longitude: -117.1611)
    let miami = CLLocationCoordinate2D(latitude: 25.7617, longitude: -80.1918)
}

// MARK: - String -

extension CompassTests {
    
    func testString() {
        
        let compassView = CircularCompassView()
        XCTAssertEqual(compassView.getString(from: 100), "100\u{00B0}")
        XCTAssertEqual(compassView.getString(from: 100.0001), "100\u{00B0}")
        XCTAssertEqual(compassView.getString(from: 100.9999), "100\u{00B0}")
    }
}

// MARK: - Heading -

extension CompassTests {
    
    func testDegreeHeading() {
        
        let compass = ArrowCompassView()
        
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
        
        let compass = ArrowCompassView()
        compass.setHeading(direction: .east, animated: false)
        
        XCTAssertEqual(compass.degrees, 90)
        XCTAssertEqual(compass.direction, .east)
    }
    
    func testDestinationHeading() {
        
        var compass = ArrowCompassView()
        
        compass.setHeading(destination: miami, origin: newYork, animated: false)
        XCTAssertEqual(compass.direction, .south)
        compass.setHeading(destination: sanDiego, origin: newYork, animated: false)
        XCTAssertEqual(compass.direction, .west)
    }
    
    func testDestinationHeadingWithCourse() {
        
        var compass = ArrowCompassView()
        
        compass.setHeading(destination: miami, origin: newYork, course: 0, animated: false)
        XCTAssertEqual(compass.direction, .south)
        compass.setHeading(destination: miami, origin: newYork, course: 180, animated: false)
        XCTAssertEqual(compass.direction, .north)
    }
}
