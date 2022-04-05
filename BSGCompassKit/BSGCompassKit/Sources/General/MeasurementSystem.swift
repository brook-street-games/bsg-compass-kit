//
//  MeasurementSystem.swift
//
//  Created by JechtSh0t on 4/4/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

///
/// Controls which units of measurements are used in some gauges.
///
public enum MeasurementSystem: String {
    
    /// Based on the metric system used in most of the world.
    case metric
    /// Based on the imperial system used in the USA.
    case imperial
    
    /// Returns the unit of speed used by the system.
    var unitOfSpeed: String {
        switch self {
        case .metric: return "km/hr"
        case .imperial: return "mi/hr"
        }
    }
}
