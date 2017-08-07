//
//  PointAndShoot.swift
//  NeuroRunner
//
//  Created by Robert Deans on 8/7/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import RealmSwift
import CoreLocation


class PointAndShoot {
    
    let locationManager: CLLocationManager = {
        $0.requestWhenInUseAuthorization()
        $0.startUpdatingHeading()
        return $0
    }(CLLocationManager())
    
    var startHeading: CLHeading?
    
    var iterations = [CLHeading]()
    
}

extension PointAndShoot {
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {


    }
    
    func recordStartHeading() {
        if let currentHeading = locationManager.heading {
            startHeading = currentHeading
            print("START HEADING = \(currentHeading.magneticHeading)")
        }
    }
    
    func recordNewIteration() {
        
    }
}
