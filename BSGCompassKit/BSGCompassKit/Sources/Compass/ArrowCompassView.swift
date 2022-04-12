//
//  ArrowCompassView.swift
//
//  Created by JechtSh0t on 4/3/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

import UIKit
import CoreLocation

///
/// An arrow shaped implementation of *Compass*.
///
public final class ArrowCompassView: GaugeView, Compass {
    
    // MARK: - Conformance Properties -
    
    private(set) public var degrees: Double = 0.0
    public var destination: CLLocationCoordinate2D?
    public var origin: CLLocationCoordinate2D?
    
    // MARK: - Properties -
    
    /// The type of label to display.
    public var labelType: LabelType = .direction
    /// The color of the compass needle.
    public var needleColor: UIColor = .label
    /// The text color.
    public var textColor: UIColor = .systemBackground
    
    // MARK: - UI -
    
    private lazy var label: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var needleImageView: UIImageView = {
        
        let imageView = UIImageView(image: UIImage(systemName: "location.north.fill"))
        imageView.tintColor = needleColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Setup -
    
    override func setup() {
        
        super.setup()
        
        addSubview(needleImageView)
        addConstraint(NSLayoutConstraint(item: needleImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: needleImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: needleImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.8, constant: 0))
        addConstraint(NSLayoutConstraint(item: needleImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.8, constant: 0))
        
        label.textColor = textColor
        label.font = getFont(size: bounds.width * 0.18)
        addSubview(label)
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.8, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.8, constant: 0))
        
        setHeading(degrees: degrees, animated: false)
    }
}

// MARK: - Label Type -

extension ArrowCompassView {
    
    public enum LabelType {
        case direction
        case distance
    }
}

// MARK: - Heading -

extension ArrowCompassView {
    
    ///
    /// Updates compass to display new information.
    /// - note: This will not show indicator for due north (359...1 degress) due to limits of circle. Left because behavior is favorable.
    ///
    /// - parameter degress: The degree value of the current heading (0-360).
    /// - parameter animated: If true, the view will animate into position.
    ///
    public func setHeading(degrees: Double, animated: Bool) {
        
        guard let direction = Direction(degrees: degrees) else { return }
        self.degrees = direction.degrees
        
        switch labelType {
        case .direction: label.text = direction.symbol
        case .distance:
            guard let origin = origin, let destination = destination else { return }
            let distanceInMeters = GaugeMath.getDistance(from: origin, to: destination)
            switch measurementSystem {
            case .metric: label.text = String(format: "%.1f km", distanceInMeters / 1000)
            case .imperial: label.text = String(format: "%.1f mi", distanceInMeters / 1609.34)
            }
        }
       
        let radians = GaugeMath.getRadians(fromDegrees: degrees)
        
        if animated {
            UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveEaseOut], animations: {
                self.needleImageView.transform = CGAffineTransform(rotationAngle: CGFloat(radians))
            })
        } else {
            needleImageView.transform = CGAffineTransform(rotationAngle: CGFloat(radians))
        }
    }
    
    public func setHeading(destination: CLLocationCoordinate2D, origin: CLLocationCoordinate2D, animated: Bool) {
        
        self.destination = destination
        self.origin = origin
        
        let degrees = GaugeMath.getDegrees(to: destination, from: origin)
        setHeading(degrees: degrees, animated: animated)
    }
}
