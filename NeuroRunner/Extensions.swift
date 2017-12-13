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
    
    // Returns a string that accounts for 0s and formats for 2 decimal places
    func returnFormattedString() -> String {
        
        if String(self).components(separatedBy: ".").last?.count == 1 {
            return "\(self)0"
        } else if String(self).components(separatedBy: ".").last?.count == 0 {
            return "\(self).00"
        } else {
            return "\(self)"
        }
        
        
    }
}
