//
//  Compass.swift
//
//  Created by JechtSh0t on 4/3/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

import CoreLocation

///
/// Set of functionality for compasses.
///
public protocol Compass: Gauge {
    
    ///
    /// Sets the heading to a new value.
    ///
    /// - parameter degrees: The degree value for the heading. Must be (0 - 360) or this method will fail silently.
    /// - parameter animated: If true, the compass will animate into position.
    ///
    func setHeading(degrees: Double, animated: Bool)
    
    ///
    /// Sets the heading to a new value.
    ///
    /// - parameter direction: The direction of the heading.
    /// - parameter animated: If true, the compass will animate into position.
    ///
    func setHeading(direction: Direction, animated: Bool)
    
    ///
    /// Sets the heading to a new value.
    ///
    /// - parameter destination: Coordinates of a destination location.
    /// - parameter origin: Coordinates of the current location.
    /// - parameter animated: If true, the compass will animate into position.
    ///
    func setHeading(destination: CLLocationCoordinate2D, origin: CLLocationCoordinate2D, animated: Bool)
    
    ///
    /// Resets the heading to due north.
    ///
    /// - parameter animated: If true, the compass will animate into position.
    ///
    func reset(animated: Bool)
}

// MARK: - Default Behavior -

extension Compass {
    
    func getString(from degrees: Double) -> String {
        "\(Int(degrees))\u{00B0}"
    }
    
    public func setHeading(destination: CLLocationCoordinate2D, origin: CLLocationCoordinate2D, animated: Bool) {
        let degrees = GaugeMath.getDegrees(to: destination, from: origin)
        setHeading(degrees: degrees, animated: animated)
    }
    
    public func setHeading(direction: Direction, animated: Bool) {
        setHeading(degrees: direction.degrees, animated: animated)
    }
    
    public func reset(animated: Bool) {
        setHeading(direction: .north, animated: animated)
    }
}
