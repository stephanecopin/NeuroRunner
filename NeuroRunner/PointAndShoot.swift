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
    var minHeading: CLHeading?
    var maxHeading: CLHeading?
    
    var updateLabelDelegate: UpdateLabelDelegate?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.startUpdatingHeading()
    }
    
}

extension PointAndShoot: CLLocationManagerDelegate {
    
    
    
    func recordStartHeading() {
        if let currentHeading = manager.heading {
            startHeading = currentHeading
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let heading = "\(newHeading.magneticHeading.roundTo(places: 4))"
        updateLabelDelegate?.updateLabel(with: heading)
        
        if let minHeading = minHeading {
            if newHeading.magneticHeading < minHeading.magneticHeading {
                self.minHeading = newHeading
            }
        } else {
            minHeading = newHeading
        }
        
        if let maxHeading = maxHeading {
            if newHeading.magneticHeading > maxHeading.magneticHeading {
                self.maxHeading = newHeading
            }
        } else {
            maxHeading = newHeading
        }

    }
}


