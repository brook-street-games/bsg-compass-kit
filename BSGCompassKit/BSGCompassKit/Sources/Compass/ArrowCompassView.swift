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
    
    // MARK: - Compass Properties -
    
    private(set) public var degrees: Double = 0.0
    public var direction: Direction { Direction(degrees: degrees)! }
    
    // MARK: - Properties -
    
    /// If true, the compass needle will form an arrow to point towards the current heading.
    public var pointToHeading = true { didSet { setup() }}
    /// The color of the compass needle.
    public var needleColor: UIColor = .label { didSet { needleImageView.tintColor = needleColor }}
    /// The text color.
    public var textColor: UIColor = .systemBackground { didSet { label.textColor = textColor }}
    /// A custom font for the label.
    public var labelFont: UIFont?
    /// The style of labels to display. Defaults to *.direction*.
    public var labelStyle: LabelStyle = .direction { didSet { updateHeading(animated: false) }}
    
    // MARK: - UI -
    
    lazy var label: UILabel = {
        
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var needleImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Setup -
    
    override func setup() {
        
        super.setup()
        
        setupNeedle()
        setupLabel()
        updateHeading(animated: false)
    }
}

// MARK: - Needle -

extension ArrowCompassView {
    
    ///
    /// Initial setup for *needleImageView*.
    ///
    private func setupNeedle() {
        
        needleImageView.image = pointToHeading ? UIImage(systemName: "location.north.fill") : UIImage(systemName: "circle.fill")
        needleImageView.tintColor = needleColor
        addSubview(needleImageView)
        addConstraint(NSLayoutConstraint(item: needleImageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: needleImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: needleImageView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.8, constant: 0))
        addConstraint(NSLayoutConstraint(item: needleImageView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.8, constant: 0))
    }
    
    ///
    /// Points the needle in a direction.
    ///
    /// - parameter degrees: The degree value of the direction to point the needle.
    /// - parameter animated: If true, the view will animate into position.
    ///
    private func setNeedle(degrees: Double, animated: Bool) {
        
        let radians = GaugeMath.getRadians(fromDegrees: degrees)
        
        if animated {
            UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveEaseOut], animations: {
                self.needleImageView.transform = CGAffineTransform(rotationAngle: CGFloat(radians))
            })
        } else {
            needleImageView.transform = CGAffineTransform(rotationAngle: CGFloat(radians))
        }
    }
}

// MARK: - Label -

extension ArrowCompassView {
    
    public enum LabelStyle {
        /// The compass will not display a label.
        case none
        /// The compass will display the direction it is pointing.
        case direction
    }
    
    ///
    /// Initial setup for *label*.
    ///
    private func setupLabel() {
        
        label.textColor = textColor
        label.font = labelFont ?? .systemFont(ofSize: bounds.width * 0.22)
        addSubview(label)
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.8, constant: 0))
        addConstraint(NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0.8, constant: 0))
    }
    
    ///
    /// Sets the label text.
    ///
    /// - parameter degrees: The degree value of the direction to set the label for.
    ///
    private func setLabel(degrees: Double) {
        
        guard let direction = Direction(degrees: degrees) else { return }
        
        switch labelStyle {
        case .none: label.text = nil
        case .direction: label.text = direction.symbol
        }
    }
}

// MARK: - Heading -

extension ArrowCompassView {
    
    ///
    /// Updates compass to display new information.
    ///
    /// - parameter degress: The degree value of the current heading (0-360).
    /// - parameter animated: If true, the view will animate into position.
    ///
    public func setHeading(degrees: Double, animated: Bool) {
        
        guard Direction(degrees: degrees) != nil else { return }
        self.degrees = degrees
        
        setNeedle(degrees: degrees, animated: animated)
        setLabel(degrees: degrees)
    }
    
    ///
    /// Sets the heading to a new value. This method uses *course* to take into account the direction the user is moving.
    ///
    /// - parameter destination: Coordinates of a destination location.
    /// - parameter origin: Coordinates of the current location.
    /// - parameter course: The degree value of the current direction.
    /// - parameter animated: If true, the compass will animate into position.
    ///
    public func setHeading(destination: CLLocationCoordinate2D, origin: CLLocationCoordinate2D, course: Double, animated: Bool) {
        
        guard Direction(degrees: course) != nil else { return }
        
        let destinationDegrees = GaugeMath.getDegrees(to: destination, from: origin)
        guard let adjustedAngle = destinationDegrees.decrement(by: course, range: 0...360) else { return }
        
        self.degrees = adjustedAngle
        setNeedle(degrees: adjustedAngle, animated: animated)
        setLabel(degrees: destinationDegrees)
    }
}
