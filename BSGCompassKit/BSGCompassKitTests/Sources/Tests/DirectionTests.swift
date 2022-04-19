//
//  DirectionTests.swift
//
//  Created by JechtSh0t on 4/5/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

import XCTest
@testable import BSGCompassKit

final class DirectionTests: XCTestCase {
    
    func testCardinalDirections() {
        
        let north = Direction(degrees: 0)!
        XCTAssertEqual(north, .north)
        XCTAssertEqual(north.opposite, .south)
        
        let east = Direction(degrees: 90)!
        XCTAssertEqual(east, .east)
        XCTAssertEqual(east.opposite, .west)
        
        let south = Direction(degrees: 180)!
        XCTAssertEqual(south, .south)
        XCTAssertEqual(south.opposite, .north)
        
        let west = Direction(degrees: 270)!
        XCTAssertEqual(west, .west)
        XCTAssertEqual(west.opposite, .east)
        
        XCTAssertNil(Direction(degrees: -1))
        XCTAssertNil(Direction(degrees: 361))
    }
}
