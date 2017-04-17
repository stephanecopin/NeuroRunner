//
//  Double Ext.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/17/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
