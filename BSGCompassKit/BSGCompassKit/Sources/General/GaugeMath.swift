//
//  GaugeMath.swift
//
//  Created by JechtSh0t on 4/3/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

import CoreGraphics
import CoreLocation

///
/// Contains mathematic functionality specific to gauges.
///
public enum GaugeMath {
    
    ///
    /// Convert an angle from degrees to radians.
    ///
    /// - parameter degrees: The angle in degrees.
    /// - returns: The angle in radians.
    ///
    public static func getRadians(fromDegrees degrees: Double) -> Double {
        return degrees * (.pi / 180)
    }
    
    ///
    /// Convert an angle from radians to degrees.
    ///
    /// - parameter radians: The angle in radians.
    /// - returns: The angle in degrees.
    ///
    public static func getDegrees(fromRadians radians: Double) -> Double {
        return radians / (.pi / 180)
    }
}

// MARK: - Heading -

extension GaugeMath {
    
    ///
    /// Get the angle between two coordinates in degrees.
    ///
    /// - parameter destination: The destination coordinate.
    /// - parameter origin: The origin coordinate.
    /// - parameter returns: The angle in degrees.
    ///
    public static func getDegrees(to destination: CLLocationCoordinate2D, from origin: CLLocationCoordinate2D) -> Double {
        
        let azimuthRadians = atan2(destination.longitude - origin.longitude, destination.latitude - origin.latitude)
        var azimuthDegrees = azimuthRadians * 180 / Double.pi
        if azimuthDegrees < 0 { azimuthDegrees = 360 + azimuthDegrees }
        return azimuthDegrees
    }
    
    ///
    /// Get the angle between two coordinates in radians.
    ///
    /// - parameter destination: The destination coordinate.
    /// - parameter origin: The origin coordinate.
    /// - parameter returns: The angle in radians.
    ///
    public static func getRadians(to destination: CLLocationCoordinate2D, from origin: CLLocationCoordinate2D) -> Double {
        
        let degrees = getDegrees(to: destination, from: origin)
        return getRadians(fromDegrees: degrees)
    }
    
    ///
    /// Get the direction of a destination form the origin.
    ///
    /// - parameter destination: The destination coordinate.
    /// - parameter origin: The origin coordinate.
    /// - parameter returns: The direction.
    ///
    public static func getDirection(to destination: CLLocationCoordinate2D, from origin: CLLocationCoordinate2D) -> Direction? {
        
        let degrees = getDegrees(to: destination, from: origin)
        return Direction(degrees: degrees)
    }
}

// MARK: - Distance -

extension GaugeMath {
    
    ///
    /// Gets the distance between coordinates.
    ///
    /// - parameter origin: Coordinates of the current location.
    /// - parameter destination: Coordinates of a destination location.
    /// - returns: The distance in meters.
    ///
    public static func getDistance(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) -> CGFloat {
        
        let originLocation = CLLocation(latitude: origin.latitude, longitude: origin.longitude)
        let destinationLocation = CLLocation(latitude: destination.latitude, longitude: destination.longitude)
        return originLocation.distance(from: destinationLocation)
    }
}

// MARK - Circle -

extension GaugeMath {
    
    /// Get one quesrter of a circle in radians.
    public static let quarterSegment = CGFloat.pi / 2
}
