//
//  Gauge.swift
//
//  Created by JechtSh0t on 4/4/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

import Foundation

///
/// Set of base functionality for all gauges.
///
public protocol Gauge {}

extension Gauge {
    
    /// The time it takes for gauge animations to complete.
    var animationDuration: TimeInterval { 2.0 }
}
