//
//  CircularCompassView.swift
//
//  Created by JechtSh0t on 4/4/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

import UIKit
import CoreLocation

///
/// A circular implementation of *Compass*.
///
public final class CircularCompassView: CircularGaugeView, Compass {
    
    // MARK: - Compass Properties -
    
    private(set) public var degrees: Double = 0.0
    public var direction: Direction { Direction(degrees: degrees)! }
    
    // MARK: - Setup -
    
    override func setup() {
        
        super.setup()
        updateHeading(animated: false)
    }
    
    override func createTicks(color: UIColor) {
        
        let tickLength = bounds.height * 0.10
        let miniTickLength = tickLength * 0.50
        
        for (index, strokeStart) in [0.00, 0.12, 0.245, 0.37, 0.495, 0.62, 0.745, 0.87].enumerated() {
            
            let tick = CAShapeLayer()
            let indicatorPath = UIBezierPath(arcCenter: self.center, radius: bounds.width * 0.40, startAngle: GaugeMath.quarterSegment * -1, endAngle: GaugeMath.quarterSegment * 3, clockwise: true)
            tick.path = indicatorPath.cgPath
            tick.strokeColor = color.cgColor
            tick.lineWidth = index % 2 == 0 ? tickLength : miniTickLength
            tick.fillColor = UIColor.clear.cgColor
            tick.lineCap = .butt
            tick.strokeStart = CGFloat(strokeStart)
            tick.strokeEnd = CGFloat(strokeStart + 0.01)
            tick.zPosition = 1
            layer.addSublayer(tick)
        }
    }
    
    override func createNeedle(color: UIColor) {
        
        let indicatorPath = UIBezierPath(arcCenter: self.center, radius: bounds.width * 0.40, startAngle: GaugeMath.quarterSegment * -1, endAngle: GaugeMath.quarterSegment * 3, clockwise: true)
        needleShapeLayer.path = indicatorPath.cgPath
        needleShapeLayer.strokeColor = color.cgColor
        needleShapeLayer.lineWidth = bounds.height * 0.10
        needleShapeLayer.fillColor = UIColor.clear.cgColor
        needleShapeLayer.lineCap = .butt
        needleShapeLayer.strokeEnd = 0
        needleShapeLayer.zPosition = 1
        layer.addSublayer(needleShapeLayer)
    }
}

// MARK: - Heading -

extension CircularCompassView {
    
    ///
    /// Sets the heading to a new value.
    /// - note: This will not show indicator for due north (359...1 degress) due to limits of circle. Left because behavior is favorable.
    ///
    /// - parameter degrees: The degree value for the heading. Must be (0 - 360) or this method will fail silently.
    /// - parameter animated: If true, the compass will animate into position.
    ///
    public func setHeading(degrees: Double, animated: Bool) {
        
        guard let direction = Direction(degrees: degrees) else { return }
        self.degrees = degrees
        
        primaryLabel.text = direction.symbol
        secondaryLabel.text = getString(from: degrees)
        
        let headingCenter = degrees / 360
        
        if animated {
            needleShapeLayer.strokeStart = headingCenter.decrement(by: 0.01, range: CGFloat(0.00)...CGFloat(1.00))!
            needleShapeLayer.strokeEnd = headingCenter.increment(by: 0.01, range: CGFloat(0.00)...CGFloat(1.00))!
        } else {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            needleShapeLayer.strokeStart = headingCenter.decrement(by: 0.01, range: CGFloat(0.00)...CGFloat(1.00))!
            needleShapeLayer.strokeEnd = headingCenter.increment(by: 0.01, range: CGFloat(0.00)...CGFloat(1.00))!
            CATransaction.commit()
        }
    }
}
