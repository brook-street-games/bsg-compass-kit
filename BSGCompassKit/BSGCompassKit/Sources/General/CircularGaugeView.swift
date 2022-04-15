//
//  CircularGaugeView.swift
//
//  Created by JechtSh0t on 4/4/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

import UIKit

///
/// Base class for circular gauges.
///
public class CircularGaugeView: GaugeView {
    
    // MARK: - Properties -
    
    /// The color of the circle border.
    public var borderColor: UIColor = .label
    /// The width of the circle border.
    public var borderWidth: CGFloat = 5.0
    /// The color of the background area within the circle.
    public var fillColor: UIColor = .systemBackground
    /// The color of the primary label.
    public var primaryTextColor: UIColor = .label
    /// The color of the secondary label.
    public var secondaryTextColor: UIColor = .label
    /// The color of the indicator tick marks.
    public var tickColor: UIColor = .lightGray
    /// The color of the needle.
    public var needleColor: UIColor = .red
    
    // MARK: - UI -
    
    lazy var primaryLabel: UILabel = {
       
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var secondaryLabel: UILabel = {
       
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var needleShapeLayer: CAShapeLayer = {
        
        let layer = CAShapeLayer()
        // This seems to map almost exactly to the correct timing.
        layer.speed = Float(0.25 / animationDuration)
        return layer
    }()
    
    // MARK: - Setup -
    
    override func setup() {
        
        super.setup()
        
        createBorder()
        createLabels()
        createTicks(color: tickColor)
        createNeedle(color: needleColor)
    }
    
    func createBorder() {
        
        let borderCircle = CAShapeLayer()
        let borderPath = UIBezierPath(arcCenter: self.center, radius: bounds.width * 0.50, startAngle: GaugeMath.quarterSegment * -1, endAngle: GaugeMath.quarterSegment * 3, clockwise: true)
        borderCircle.path = borderPath.cgPath
        borderCircle.strokeColor = borderColor.cgColor
        borderCircle.lineWidth = borderWidth
        borderCircle.fillColor = fillColor.cgColor
        borderCircle.lineCap = .round
        borderCircle.strokeEnd = 1
        borderCircle.zPosition = -1
        layer.addSublayer(borderCircle)
    }
    
    func createLabels() {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: stackView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        primaryLabel.font = getFont(size: bounds.width * 0.28)
        primaryLabel.textColor = primaryTextColor
        stackView.addArrangedSubview(primaryLabel)
        
        secondaryLabel.font = getFont(size: bounds.width * 0.14)
        secondaryLabel.textColor = secondaryTextColor
        stackView.addArrangedSubview(secondaryLabel)
        
        addSubview(stackView)
    }
    
    func createTicks(color: UIColor) {}
    func createNeedle(color: UIColor) {}
}
