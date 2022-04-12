//
//  GaugeView.swift
//
//  Created by JechtSh0t on 4/6/22.
//  Copyright © 2022 Brook Street Games. All rights reserved.
//

import UIKit

///
/// Base class for all gauges.
///
public class GaugeView: UIView, Gauge {
    
    // MARK: - Conformance Properties -
    
    public var measurementSystem: MeasurementSystem = .imperial
    public var customFontName: String?
    public var animationDuration: TimeInterval = 1.0
    
    // MARK: - Setup -
    
    override public func didMoveToSuperview() {
        
        super.didMoveToSuperview()
        setup()
    }
    
    override public func draw(_ rect: CGRect) {
    
        super.draw(rect)
        setup()
    }
    
    func setup() {
        
        for view in subviews { view.removeFromSuperview() }
        for sublayer in layer.sublayers ?? [] { sublayer.removeFromSuperlayer() }
    }
}
