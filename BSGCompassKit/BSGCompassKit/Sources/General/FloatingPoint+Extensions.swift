//
//  FloatingPoint+Extensions.swift
//
//  Created by JechtSh0t on 4/5/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

///
/// Functionality copied from *bsg-app-basics* to avoid a dependency.
///
extension FloatingPoint {
    
    ///
    /// Increase value by a desired amount.
    ///
    /// - parameter increment: The amount to increase by. This must be contained in *range*, or nil will be returned.
    /// - parameter range: Limits the range of the return value.
    /// - parameter shouldWrap: If true, the value will loop around *range* when the bounds are exceeded. If false, the max or min value will be returned when the bounds are exceeded.
    /// - returns: A new value with the increment applied.
    ///
    public func increment(by increment: Self, range: ClosedRange<Self>, shouldWrap: Bool = true) -> Self? {
        
        guard range.contains(self) else { return nil }
        guard increment >= 0 else { return decrement(by: -increment, range: range, shouldWrap: shouldWrap) }
        
        if range.contains(self + increment) {
            return self + increment
        } else if shouldWrap {
            let adjustedIncrement = increment.truncatingRemainder(dividingBy: range.upperBound + 1)
            return self + adjustedIncrement
        } else {
            return range.upperBound
        }
    }
    
    ///
    /// Decrease value by a desired amount.
    ///
    /// - parameter increment: The amount to increase by. This must be contained in *range*, or nil will be returned.
    /// - parameter range: Limits the range of the return value.
    /// - parameter shouldWrap: If true, the value will loop around *range* when the bounds are exceeded. If false, the max or min value will be returned when the bounds are exceeded.
    /// - returns: A new value with the increment applied.
    ///
    public func decrement(by decrement: Self, range: ClosedRange<Self>, shouldWrap: Bool = true) -> Self? {
        
        guard range.contains(self) else { return nil }
        guard decrement >= 0 else { return increment(by: -decrement, range: range, shouldWrap: shouldWrap) }
        
        if range.contains(self - decrement) {
            return self - decrement
        } else if shouldWrap {
            let adjustedDecrement = decrement.truncatingRemainder(dividingBy: range.upperBound + 1)
            return self - adjustedDecrement
        } else {
            return range.lowerBound
        }
    }
    
    ///
    /// Confines the current value to a range. If the value is lower or higher than the range, this will return the lowest or highest value in the range respectively. IF the current values is already contained in *range* it will be returned with no change.
    ///
    /// - parameter range: The range to confine to.
    /// - returns: The current value confined to *range*.
    ///
    public func confine(to range: ClosedRange<Self>) -> Self {
        
        switch self {
        case ...range.lowerBound: return range.lowerBound
        case range.upperBound...: return range.upperBound
        default: return self
        }
    }
}
