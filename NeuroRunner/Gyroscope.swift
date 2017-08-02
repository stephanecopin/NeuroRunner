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

class Gyroscope {

    let manager = CMMotionManager()
    
    var timeElapsed = 0.0
    
    var timeMagnitudes = [TimeMagnitude]()
    
    let minimumVariation = 0.1
    
}

extension Gyroscope {
    
    func start() {
        
        var previousAcc = 0.0
        
        if manager.isDeviceMotionAvailable {
        
            manager.deviceMotionUpdateInterval = collectionInterval

            manager.startDeviceMotionUpdates(to: .main) {
                (data: CMDeviceMotion?, error: Error?) in
            
                if let x = data?.userAcceleration.x,
                    let y = data?.userAcceleration.y,
                    let z = data?.userAcceleration.z {
                    let totalAcc = (x + y + z).roundTo(places: 6)
   
                    self.timeElapsed += collectionInterval
   
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
