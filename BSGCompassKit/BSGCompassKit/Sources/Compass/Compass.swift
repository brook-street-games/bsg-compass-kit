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
    
    /// The current degree value.
    var degrees: Double { get }
    /// The current direction value.
    var direction: Direction { get }
    /// The coordinates of the compass destination.
    var destination: CLLocationCoordinate2D? { get set }
    /// The coordinates of the compass user.
    var origin: CLLocationCoordinate2D? { get set }
    
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
    mutating func setHeading(destination: CLLocationCoordinate2D, origin: CLLocationCoordinate2D, animated: Bool)
    
    ///
    /// Sets the heading to a new value. This method uses *course* to take into account the direction the user is moving.
    ///
    /// - parameter destination: Coordinates of a destination location.
    /// - parameter origin: Coordinates of the current location.
    /// - parameter course: The degree value of the current direction.
    /// - parameter animated: If true, the compass will animate into position.
    ///
    mutating func setHeading(destination: CLLocationCoordinate2D, origin: CLLocationCoordinate2D, course: Double, animated: Bool)
    
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
    
    public func setHeading(direction: Direction, animated: Bool) {
        setHeading(degrees: direction.degrees, animated: animated)
    }
    
    public mutating func setHeading(destination: CLLocationCoordinate2D, origin: CLLocationCoordinate2D, animated: Bool) {
        
        self.destination = destination
        self.origin = origin
        
        let destinationDegrees = GaugeMath.getDegrees(to: destination, from: origin)
        setHeading(degrees: destinationDegrees, animated: animated)
    }
    
    public mutating func setHeading(destination: CLLocationCoordinate2D, origin: CLLocationCoordinate2D, course: Double, animated: Bool) {
        
        self.destination = destination
        self.origin = origin
        
        let destinationDegrees = GaugeMath.getDegrees(to: destination, from: origin)
        guard let destinationAngle = destinationDegrees.decrement(by: course, range: 0...360) else { return }
        setHeading(degrees: destinationAngle, animated: animated)
    }
    
    public func reset(animated: Bool) {
        setHeading(direction: .north, animated: animated)
    }
}
