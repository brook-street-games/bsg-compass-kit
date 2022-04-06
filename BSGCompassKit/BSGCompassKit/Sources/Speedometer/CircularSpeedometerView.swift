//
//  CircularSpeedometerView.swift
//
//  Created by JechtSh0t on 4/4/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

import UIKit

///
/// A circular implementation of *Speedometer*.
///
public final class CircularSpeedometerView: CircularGaugeView, Speedometer {
    
    // MARK: - Nested Types -
    
    public enum NeedleType {
        case marker, bar
    }
    
    // MARK: - Conformance Properties -
    
    private(set) public var speed: Double = 0.0
    public var measurementSystem: MeasurementSystem = .imperial { didSet { update() }}
    public var maxSpeed: Double = 120.0 { didSet { update() }}
    
    // MARK: - Properties -
    
    /// The type of needle used to indicate speed.
    public var needleType: NeedleType = .bar { didSet { update() }}
    
    // MARK: - Initializers -
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup -
    
    override func setup() {
        
        super.setup()
        reset(animated: false)
    }
    
    override func createTicks(color: UIColor) {
        
        for strokeStart in [0.00, 0.19, 0.39, 0.59, 0.79, 0.98] {
            
            let tick = CAShapeLayer()
            let indicatorPath = UIBezierPath(arcCenter: self.center, radius: bounds.width * 0.40, startAngle: GaugeMath.quarterSegment * -2, endAngle: GaugeMath.quarterSegment * 0, clockwise: true)
            tick.path = indicatorPath.cgPath
            tick.strokeColor = color.cgColor
            tick.lineWidth = bounds.height * 0.10
            tick.fillColor = UIColor.clear.cgColor
            tick.lineCap = .butt
            tick.strokeStart = CGFloat(strokeStart)
            tick.strokeEnd = CGFloat(strokeStart + 0.02)
            tick.zPosition = 1
            layer.addSublayer(tick)
        }
    }
    
    override func createNeedle(color: UIColor) {
        
        let indicatorPath = UIBezierPath(arcCenter: self.center, radius: bounds.width * 0.40, startAngle: GaugeMath.quarterSegment * -2, endAngle: GaugeMath.quarterSegment * 0, clockwise: true)
        needleShapeLayer.path = indicatorPath.cgPath
        needleShapeLayer.strokeColor = color.cgColor
        needleShapeLayer.lineWidth = bounds.height * 0.10
        needleShapeLayer.fillColor = UIColor.clear.cgColor
        needleShapeLayer.lineCap = .butt
        needleShapeLayer.strokeEnd = 0
        needleShapeLayer.zPosition = 2
        layer.addSublayer(needleShapeLayer)
    }
    
    override func update() {
        setSpeed(speed, animated: false)
    }
}

// MARK: - Speed -

extension CircularSpeedometerView {
    
    public func setSpeed(_ speed: Double, animated: Bool) {
        
        let confinedSpeed = speed.confine(to: 0...maxSpeed)
        self.speed = confinedSpeed
        
        primaryLabel.text = getString(from: confinedSpeed)
        secondaryLabel.text = measurementSystem.unitOfSpeed
        
        let speedCenter = confinedSpeed / maxSpeed
        
        if animated {
            adjustNeedle(center: speedCenter)
        } else {
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            adjustNeedle(center: speedCenter)
            CATransaction.commit()
        }
    }
    
    private func adjustNeedle(center: Double) {
        
        switch needleType {
        case .marker:
            needleShapeLayer.strokeStart = center.decrement(by: 0.02, range: CGFloat(0.00)...CGFloat(1.00))!
            needleShapeLayer.strokeEnd = center.increment(by: 0.02, range: CGFloat(0.00)...CGFloat(1.00))!
        case .bar:
            needleShapeLayer.strokeEnd = center
        }
    }
}
