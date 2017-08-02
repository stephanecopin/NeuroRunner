//
//  IntervalTimer.swift
//  NeuroRunner
//
//  Created by Robert Deans on 5/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

// TODO: Good practice? Acts as a universal collection interval for gyroscope and timer
let collectionInterval = 0.05

class MagnitudeTimer {
    
    var timer: Timer!
    var intervals = [Double]()
    var intervalTime = 0.0
    lazy var gyroscope = Gyroscope()
    
}

extension MagnitudeTimer {
    
    func start() {
        self.gyroscope.start()
        
        timer = Timer.scheduledTimer(withTimeInterval: collectionInterval, repeats: true, block: { (timer) in

            self.intervals.append(self.intervalTime)
            self.intervalTime += collectionInterval
            
        })
    }
    
    func stop() {
        gyroscope.stop()
        if let timer = timer {
            timer.invalidate()
        }
    }
    
    func clearTimer() {
        intervals = []
        intervalTime = 0.0
    }
    
}
