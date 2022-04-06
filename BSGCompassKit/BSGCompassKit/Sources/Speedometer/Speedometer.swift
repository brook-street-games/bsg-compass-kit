//
//  Speedometer.swift
//
//  Created by JechtSh0t on 4/4/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

///
/// Set of functionality for speedometers.
///
public protocol Speedometer: Gauge {
    
    /// The unit of measurement used for speed.
    var measurementSystem: MeasurementSystem { get set }
    /// The current speed.
    var speed: Double { get }
    /// Controls the range of speeds a speedometer can display. This value be take the form of mi/hr or km/hr based on *measurementSystem*.
    var maxSpeed: Double { get set }
    
    ///
    /// Sets the speed to a new value.
    ///
    /// - parameter speed: The new speed value. The value of *measurementSystem* will determine which unit of measurement is used.
    /// - parameter animated: If true, the speedometer will animate into position.
    ///
    func setSpeed(_ speed: Double, animated: Bool)
    
    ///
    /// Resets the speed to zero.
    ///
    /// - parameter animated: If true, the speedometer will animate into position.
    ///
    func reset(animated: Bool)
}

// MARK: - Default Behavior -

extension Speedometer {
    
    func getString(from speed: Double) -> String {
        String(Int(speed))
    }
    
    public func reset(animated: Bool) {
        setSpeed(0, animated: animated)
    }
}
