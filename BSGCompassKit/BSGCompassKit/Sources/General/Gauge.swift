//
//  Gauge.swift
//
//  Created by JechtSh0t on 4/4/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

import UIKit

///
/// Set of base functionality for all gauges.
///
public protocol Gauge {
    
    /// The unit of measurement used for speed.
    var measurementSystem: MeasurementSystem { get set }
    /// The time it takes for gauge animations to complete.
    var animationDuration: TimeInterval { get set }
}
