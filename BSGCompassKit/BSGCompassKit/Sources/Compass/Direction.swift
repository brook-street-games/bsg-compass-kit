//
//  Direction.swift
//
//  Created by JechtSh0t on 4/3/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

///
/// Represents cardinal and ordinal directions.
///
public enum Direction: String, CaseIterable {
    
    // MARK: - Cases -
    
    case north, east, south, west
    case northEast, southEast, southWest, northWest
    
    // MARK: - Initializers -
    
    public init?(degrees: Double) {
        
        guard degrees >= 0 && degrees <= 360 else { return nil }
        
        switch degrees {
        case 22.5...67.5: self = .northEast
        case 67.5...112.5: self = .east
        case 112.5...157.5: self = .southEast
        case 157.5...202.5: self = .south
        case 202.5...247.5: self = .southWest
        case 247.5...292.5: self = .west
        case 292.5...337.5: self = .northWest
        default: self = .north
        }
    }
}

// MARK: - Text -

extension Direction {
    
    ///
    /// Symbol representation of the direction.
    ///
    public var symbol: String {
        
        switch self {
        case .north: return "N"
        case .east: return "E"
        case .south: return "S"
        case .west: return "W"
        case .northEast: return "NE"
        case .southEast: return "SE"
        case .southWest: return "SW"
        case .northWest: return "NW"
        }
    }
    
    ///
    /// Full text describing the direction.
    ///
    public var fullName: String {
        
        switch self {
        case .north: return "North"
        case .east: return "East"
        case .south: return "South"
        case .west: return "West"
        case .northEast: return "Northeast"
        case .southEast: return "Southeast"
        case .southWest: return "Southwest"
        case .northWest: return "Northwest"
        }
    }
}

// MARK: - Directions -

extension Direction {
    
    ///
    /// Degree value for the center of the direction.
    ///
    public var degrees: Double {
        switch self {
        case .north: return 0
        case .northEast: return 45
        case .east: return 90
        case .southEast: return 135
        case .south: return 180
        case .southWest: return 225
        case .west: return 270
        case .northWest: return 315
        }
    }
    
    ///
    /// The direction 180 degress from the current one.
    ///
    public var opposite: Direction {
        
        switch self{
        case .north: return .south
        case .east: return .west
        case .south: return .north
        case .west: return .east
        case .northEast: return .southWest
        case .southEast: return .northWest
        case .southWest: return .northEast
        case .northWest: return .southEast
        }
    }

    ///
    /// All directions lying directly next to the current direction on an ordinal scale. Includes the current direction.
    ///
    public var adjacentOrdinalDirections: [Direction] {
        
        switch self {
        case .north: return [.northWest, .north, .northEast]
        case .east: return [.northEast, .east, .southEast]
        case .south: return [.southEast, .south, .southWest]
        case .west: return [.southWest, .west, .northWest]
        case .northEast: return [.north, .northEast, .east]
        case .southEast: return [.east, .southEast, .south]
        case .southWest: return [.south, .southWest, .west]
        case .northWest: return [.west, .northWest, .north]
        }
    }
    
    ///
    /// All directions in the forward plane.
    ///
    public var hemishpereDirections: [Direction] {
        Direction.allCases.filter { !$0.opposite.adjacentOrdinalDirections.contains(self) }
    }
}
