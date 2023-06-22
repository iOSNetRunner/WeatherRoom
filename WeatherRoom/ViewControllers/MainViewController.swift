//
//  MainViewController.swift
//  WeatherRoom
//
//  Created by Dmitrii Galatskii on 19.06.2023.
//

import UIKit
import SpringAnimation

final class MainViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet var logoImage: SpringImageView!
    @IBOutlet var titleLabel: SpringLabel!
    @IBOutlet var enterButton: SpringButton!
    
    //MARK: View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.setGradientBackground()
        setAnimation()
        
    }
    
    //MARK: - Private Methods
    private func setAnimation() {
        logoImage.animation = "zoomIn"
        logoImage.delay = 0
        logoImage.duration = 2
        
        titleLabel.animation = "zoomIn"
        titleLabel.delay = 0.2
        titleLabel.duration = 2
        
        enterButton.animation = "zoomIn"
        enterButton.animate()
        
        enterButton.animation = "pop"
        enterButton.duration = 2
        enterButton.repeatCount = .infinity
        
        logoImage.animate()
        titleLabel.animate()
        enterButton.animate()
    }
}
