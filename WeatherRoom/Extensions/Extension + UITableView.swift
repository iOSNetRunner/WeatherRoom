//
//  Extension + UITableView.swift
//  WeatherRoom
//
//  Created by Dmitrii Galatskii on 22.06.2023.
//

import UIKit

extension UITableView {
    func setTableViewGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.removeFromSuperlayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor.clear.cgColor,
                                UIColor.systemCyan.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.shouldRasterize = true
        self.layer.addSublayer(gradientLayer)
    }
}
