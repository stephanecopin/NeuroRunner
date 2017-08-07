//
//  InputTimer.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/14/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

class ManualInputTimer {
    
    var inputTimer: Timer!
    var totalInputTime = 0.0
    
}

extension ManualInputTimer {
    
    func addUsingManual() {
        inputTimer = Timer.scheduledTimer(withTimeInterval: timerCollectionInterval, repeats: true) { (timer) in
            self.totalInputTime += timerCollectionInterval
        }
    }
    
    func reset() {
        totalInputTime = 0.0
        if inputTimer != nil {
            inputTimer.invalidate()
        }
    }
    
}
