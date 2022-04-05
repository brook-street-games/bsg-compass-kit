//
//  GaugeMathTests.swift
//
//  Created by JechtSh0t on 4/5/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

import XCTest
@testable import BSGCompassKit

final class GaugeMathTests: XCTestCase {
    
    func testRadianConversion() {
        
        XCTAssertEqual(GaugeMath.getRadians(fromDegrees: 180), 3.141592653589793)
        XCTAssertEqual(GaugeMath.getRadians(fromDegrees: 360), 6.283185307179586)
    }
    
    func testDegreeConversion() {
        
        XCTAssertEqual(GaugeMath.getDegrees(fromRadians: 3.141592653589793), 180)
        XCTAssertEqual(GaugeMath.getDegrees(fromRadians: 6.283185307179586), 360)
    }
}
