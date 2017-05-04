//
//  IntervalTimer.swift
//  NeuroRunner
//
//  Created by Robert Deans on 5/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

class IntervalTimer {
    
    var timer: Timer!
    
    lazy var gyroscope = Gyroscope()
    
}

extension IntervalTimer {
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { (timer) in
            
            self.gyroscope.start()
            
        })
    }
    
    func stop() {
        if let timer = timer {
            timer.invalidate()
            print("MAGNITUDES = \(self.gyroscope.stop())")
            self.gyroscope.magnitudes = []
        }
    }
    
}
