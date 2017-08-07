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
        
        if let minHeading = minHeading, let maxHeading = maxHeading {
            let currentString = "\(newHeading.magneticHeading.roundTo(places: 4))"
            let minString = "\(minHeading.magneticHeading.roundTo(places: 4))"
            let maxString = "\(maxHeading.magneticHeading.roundTo(places: 4))"
            
            updateLabelDelegate?.updateHeadingLabel(with: currentString, min: minString, max: maxString)
            
        }
    }
    
}


