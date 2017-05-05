//
//  Gyroscope.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/14/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import CoreMotion

class Gyroscope {

    let manager = CMMotionManager()
    let queue = OperationQueue()

    var magnitudes = [Double]()
    

}

extension Gyroscope {
    
    func start() {
        print("gyroscope starting")
        if manager.isDeviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 0.02
            manager.startDeviceMotionUpdates(to: .main) {
                (data: CMDeviceMotion?, error: Error?) in
                if let x = data?.userAcceleration.x {
                    
                    self.magnitudes.append(x.roundTo(places: 6))
                    
                }
            }
        }
    }
    
    func stop() {
        manager.stopGyroUpdates()
    }
}
