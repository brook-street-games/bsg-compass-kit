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
    /// The name of a custom font to use.
    var customFontName: String? { get set }
    /// The time it takes for gauge animations to complete.
    var animationDuration: TimeInterval { get set }
}

extension Gauge {
    
    ///
    /// Gets the correct font for a specified size.
    ///
    /// - parameter size: The size of the font.
    /// - returns: A font object.
    ///
    func getFont(size: Double) -> UIFont {
        
        if let customFontName = customFontName {
            return UIFont(name: customFontName, size: size) ?? .systemFont(ofSize: size)
        } else {
            return .systemFont(ofSize: size)
        }
    }
}
