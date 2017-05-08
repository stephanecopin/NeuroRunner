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
    var magnitudes = [Double]()
}

extension Gyroscope {
    
    func start() {
        if manager.isDeviceMotionAvailable {
            manager.deviceMotionUpdateInterval = collectionInterval
            manager.startDeviceMotionUpdates(to: .main) {
                (data: CMDeviceMotion?, error: Error?) in
                if let x = data?.userAcceleration.x, let y = data?.userAcceleration.y, let z = data?.userAcceleration.z {
                    let totalAcc = x + y + z
                    // TODO find a way to triangulate coordinates
                    self.magnitudes.append(totalAcc.roundTo(places: 6))
                    
                }
            }
        }
    }
    
    func stop() {
        manager.stopGyroUpdates()
    }
}
