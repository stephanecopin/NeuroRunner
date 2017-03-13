//
//  Colors.swift
//  NeuroRunner
//
//  Created by Robert Deans on 3/12/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

// MARK: Theme Colors
extension UIColor {
    public static let themeMarine = UIColor(red: 34 / 255, green: 91 / 255, blue: 102 / 255, alpha: 1)
    public static let themeTeal = UIColor(red: 23 / 255, green: 163 / 255, blue: 165 / 255, alpha: 1)
    public static let themeGrass = UIColor(red: 141 / 255, green: 191 / 255, blue: 103 / 255, alpha: 1)
    public static let themeSunshine = UIColor(red: 252 / 255, green: 203 / 255, blue: 95 / 255, alpha: 1)
    public static let themeCoral = UIColor(red: 252 / 255, green: 110 / 255, blue: 89 / 255, alpha: 1)
    public static let themeWhite = UIColor(red: 250 / 255, green: 250 / 255, blue: 250 / 255, alpha: 1)
    
    public static let startButtonStart = UIColor(red: 0/255, green: 37/255, blue: 127/255, alpha: 1)
    public static let startButtonStop = UIColor(red: 178/255, green: 18/255, blue: 18/255, alpha: 1)
    
    public static let breathingButtonOn = UIColor(red: 0/255, green: 230/255, blue: 255/255, alpha: 1)
    public static let breathingButtonOff = UIColor(red: 90/255, green: 0/255, blue: 168/255, alpha: 1)

}

// MARK: Gradients
extension CAGradientLayer {
    convenience init(_ colors: [UIColor]) {
        self.init()
        
        self.colors = colors.map { $0.cgColor }
    }
}

extension CALayer {
    
    public static func makeGradient(firstColor: UIColor, secondColor: UIColor) -> CAGradientLayer {
        let backgroundGradient = CAGradientLayer()
        
        backgroundGradient.colors = [firstColor.cgColor, secondColor.cgColor]
        backgroundGradient.locations = [0, 1]
        backgroundGradient.startPoint = CGPoint(x: 0, y: 0)
        backgroundGradient.endPoint = CGPoint(x: 0, y: 1)
        
        return backgroundGradient
    }
}
