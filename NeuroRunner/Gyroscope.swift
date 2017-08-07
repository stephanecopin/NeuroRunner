//
//  Gyroscope.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/14/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import CoreMotion
import Foundation

typealias TimeMagnitude = (Time: Double, Magnitude: Double)

let timerCollectionInterval = 0.05

class Gyroscope {
    
    let manager = DataStore.shared.user.cmmanager
    
    var timeElapsed = 0.0
    
    var timeMagnitudes = [TimeMagnitude]()
    
    let minimumVariation = 0.1
    
}

extension Gyroscope {
    
    func start() {
        
        var previousAcc = 0.0
        
        if manager.isDeviceMotionAvailable {
        
            manager.deviceMotionUpdateInterval = timerCollectionInterval

            manager.startDeviceMotionUpdates(to: .main) {
                (data: CMDeviceMotion?, error: Error?) in
            
                if let x = data?.userAcceleration.x,
                    let y = data?.userAcceleration.y,
                    let z = data?.userAcceleration.z {
                    let totalAcc = (x + y + z).roundTo(places: 6)
   
                    self.timeElapsed += timerCollectionInterval
   
                    if abs(totalAcc - previousAcc) > self.minimumVariation {
                        previousAcc = totalAcc
                        self.timeMagnitudes.append((self.timeElapsed, totalAcc))
                        print((self.timeElapsed, totalAcc))
                        print("previousAcc is now \(previousAcc)")
                    }
                    
                    
                }
            }
        }
    }
    
    func stop() {
        manager.stopGyroUpdates()
        manager.stopDeviceMotionUpdates()
    }
    
    func reset() {
        timeElapsed = 0.0
        timeMagnitudes = []
    }
}
