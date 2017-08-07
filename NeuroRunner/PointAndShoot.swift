//
//  PointAndShoot.swift
//  NeuroRunner
//
//  Created by Robert Deans on 8/7/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import RealmSwift
import CoreLocation


class PointAndShoot: NSObject {
    
    let manager = DataStore.shared.user.locationManager
    
    var startHeading: CLHeading?
    
    var iterations = [CLHeading]()
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
}

extension PointAndShoot: CLLocationManagerDelegate {
    
    
    
    func recordStartHeading() {
        manager.startUpdatingHeading()

        if let currentHeading = manager.heading {
            startHeading = currentHeading
            print("START HEADING = \(currentHeading.magneticHeading)")
        }
    }
    
    func recordNewIteration() {
        
    }
}
