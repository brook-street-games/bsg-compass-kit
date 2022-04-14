//
//  SampleViewController.swift
//
//  Created by JechtSh0t on 4/3/22.
//  Copyright © 2022 Brook Street Games LLC. All rights reserved.
//

import UIKit
import BSGCompassKit

///
/// Sample application to explore available compasses.
///
final class SampleViewController: UIViewController {
    
    // MARK: - UI -
    
    /// The area that hosts *needleCompassView*
    @IBOutlet private weak var arrowCompassContainer: UIView!
    /// The area that hosts *circleCompassView*
    @IBOutlet private weak var circularCompassContainer: UIView!
    
    /// A compass with the arrow style.
    private var arrowCompassView: ArrowCompassView = {
        
        let compassView = ArrowCompassView()
        return compassView
    }()
    
    /// A compass with the circular style.
    private var circularCompassView: CircularCompassView = {
        
        let compassView = CircularCompassView()
        compassView.borderColor = .black
        compassView.fillColor = .black
        compassView.tickColor = .yellow
        compassView.primaryTextColor = .white
        compassView.secondaryTextColor = .white
        compassView.needleColor = .white
        return compassView
    }()
    
    // MARK: - Setup -
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        createCompasses()
        startHeadings()
    }
}

// MARK: - Compasses -

extension SampleViewController {
    
    ///
    /// Creates a needle compass.
    ///
    private func createCompasses() {
        
        let compassViews = [arrowCompassView, circularCompassView]
        let containers: [UIView] = [arrowCompassContainer, circularCompassContainer]
        
        for (index, container) in containers.enumerated() {
            
            let compassView = compassViews[index]
            container.addSubview(compassView)
            compassView.translatesAutoresizingMaskIntoConstraints = false
            
            container.addConstraint(NSLayoutConstraint(item: compassView, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0))
            container.addConstraint(NSLayoutConstraint(item: compassView, attribute: .right, relatedBy: .equal, toItem: container, attribute: .right, multiplier: 1.0, constant: 0))
            container.addConstraint(NSLayoutConstraint(item: compassView, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0))
            container.addConstraint(NSLayoutConstraint(item: compassView, attribute: .left, relatedBy: .equal, toItem: container, attribute: .left, multiplier: 1.0, constant: 0))
        }
    }
}

// MARK: - Direction Randomizer -

extension SampleViewController {
    
    ///
    /// Starts randomizes compass headings to show animation.
    ///
    func startHeadings() {
        
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { _ in
            
            let randomDegrees = Double.random(in: 0...360)
            self.arrowCompassView.setHeading(degrees: randomDegrees, animated: true)
            self.circularCompassView.setHeading(degrees: randomDegrees, animated: true)
        })
    }
}
