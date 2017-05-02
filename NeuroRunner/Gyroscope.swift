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

}

extension Gyroscope {
    
    func start() {
        if manager.isDeviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 0.02
            manager.startDeviceMotionUpdates(to: .main) {
                (data: CMDeviceMotion?, error: Error?) in
                if let x = data?.userAcceleration.x,
                    x < -2.5 {
                        print("wobble wobble wobble")
                        // Wobble!
                }
            }
        }
    }
    
    func stop() {
        manager.stopGyroUpdates()
    }
}
