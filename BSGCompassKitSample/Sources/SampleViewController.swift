//
//  SampleViewController.swift
//  Sample
//
//  Created by JechtSh0t on 8/21/21.
//

import UIKit
import BSGCompassKit

///
/// Sample application to explore available compasses.
///
final class SampleViewController: UIViewController {
    
    // MARK: - Properties -
    
    /// A compass with the needle style.
    private var needleCompassView: NeedleCompassView!
    /// A compass with the circular style.
    private var circleCompassView: CircularCompassView!
    
    // MARK: - UI -
    
    /// The area that hosts *needleCompassView*
    @IBOutlet private weak var needleCompassContainer: UIView!
    /// The area that hosts *circleCompassView*
    @IBOutlet private weak var circleCompassContainer: UIView!
    
    // MARK: - Setup -
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        createNeedleCompass()
        createCircleCompass()
        startHeadings()
    }
}

// MARK: - Compasses -

extension SampleViewController {
    
    ///
    /// Creates a needle compass.
    ///
    private func createNeedleCompass() {
        
        let compassView = NeedleCompassView(frame: needleCompassContainer.bounds)
        needleCompassContainer.addSubview(compassView)
        self.needleCompassView = compassView
    }
    
    ///
    /// Creates a circular compass.
    ///
    private func createCircleCompass() {
        
        let compassView = CircularCompassView(frame: circleCompassContainer.bounds)
        compassView.borderColor = .black
        compassView.fillColor = .black
        compassView.tickColor = .yellow
        compassView.primaryTextColor = .white
        compassView.secondaryTextColor = .white
        compassView.needleColor = .white
        
        circleCompassContainer.addSubview(compassView)
        self.circleCompassView = compassView
    }
}

// MARK: - Direction Randomizer -

extension SampleViewController {
    
    func startHeadings() {
        
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true, block: { _ in
            
            let randomDegrees = Double.random(in: 0...360)
            self.needleCompassView.setHeading(degrees: randomDegrees, animated: true)
            self.circleCompassView.setHeading(degrees: randomDegrees, animated: true)
        })
    }
}
