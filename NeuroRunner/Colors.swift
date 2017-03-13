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
    // Pups & Playgrounds theme
    public static let themeMarine = UIColor(red: 34 / 255, green: 91 / 255, blue: 102 / 255, alpha: 1)
    public static let themeTeal = UIColor(red: 23 / 255, green: 163 / 255, blue: 165 / 255, alpha: 1)
    public static let themeGrass = UIColor(red: 141 / 255, green: 191 / 255, blue: 103 / 255, alpha: 1)
    public static let themeSunshine = UIColor(red: 252 / 255, green: 203 / 255, blue: 95 / 255, alpha: 1)
    public static let themeCoral = UIColor(red: 252 / 255, green: 110 / 255, blue: 89 / 255, alpha: 1)
    public static let themeWhite = UIColor(red: 250 / 255, green: 250 / 255, blue: 250 / 255, alpha: 1)
    
    // GameView Colors
    public static let startButtonStart = UIColor(red: 0/255, green: 37/255, blue: 127/255, alpha: 1)
    public static let startButtonStop = UIColor(red: 178/255, green: 18/255, blue: 18/255, alpha: 1)
    
    public static let breathingButtonOn = UIColor(red: 0/255, green: 230/255, blue: 255/255, alpha: 1)
    public static let breathingButtonOff = UIColor(red: 90/255, green: 0/255, blue: 168/255, alpha: 1)

    // GameSummary Colors
    public static let darkColor1 = UIColor(red: 78/255, green: 0/255, blue: 156/255, alpha: 1)
    public static let darkColor2 = UIColor(red: 0/255, green: 29/255, blue: 222/255, alpha: 1)
    public static let darkColor3 = UIColor(red: 29/255, green: 112/255, blue: 93/255, alpha: 1)

    public static let lightColor1 = UIColor(red: 255/255, green: 247/255, blue: 118/255, alpha: 1)
    public static let lightColor2 = UIColor(red: 0/255, green: 230/255, blue: 255/255, alpha: 1)
    public static let lightColor3 = UIColor(red: 65/255, green: 255/255, blue: 211/255, alpha: 1)

    
    func generateRandomColor() -> UIColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        
        return color
    }
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
