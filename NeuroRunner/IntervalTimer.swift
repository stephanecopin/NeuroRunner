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
    var intervals = [Double]()
    var intervalTime = 0.0
    lazy var gyroscope = Gyroscope()
    
}

extension IntervalTimer {
    
    func start() {
        self.gyroscope.start()
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true, block: { (timer) in

            self.intervals.append(self.intervalTime)
            self.intervalTime += 0.02
            
        })
    }
    
    func stop() {
        if let timer = timer {
            timer.invalidate()
            gyroscope.stop()
        }
    }
    
}
