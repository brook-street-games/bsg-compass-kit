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
    
    public var customFontName: String?
    
    // MARK: - Setup -
    
    override public func draw(_ rect: CGRect) {
    
        for view in subviews { view.removeFromSuperview() }
        for sublayer in layer.sublayers ?? [] { sublayer.removeFromSuperlayer() }
        
        setup()
    }
    
    func setup() {}
}
