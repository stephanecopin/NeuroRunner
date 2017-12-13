//
//  PointAndShoot.swift
//  NeuroRunner
//
//  Created by Robert Deans on 8/7/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import RealmSwift
import CoreLocation

// Class uses magnetic north to avoid location-based conversions

class PointAndShoot: NSObject {
    
    let manager = DataStore.shared.user.locationManager
    var updateLabelDelegate: UpdateLabelDelegate?

    var startHeading: Double?
    var minHeading: Double?
    var maxHeading: Double?
    
    var leftMax = 0.0
    var rightMax = 0.0
    
    var isShooting = false
    var decPlaces = 2
    
    override init() {
        super.init()
        manager.delegate = self
        manager.startUpdatingHeading()
    }
    
}

extension PointAndShoot: CLLocationManagerDelegate {
    
    func recordStartHeading() {
        if let currentHeading = manager.heading?.magneticHeading.roundTo(places: 2) {
            startHeading = currentHeading
        }
    }
    
    // TODO: Clean this up
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        if isShooting {
            
            let current = Double(newHeading.magneticHeading)
            
            if let startHeading = startHeading {
                
                let distanceAndDirection = findDegreesAndDirection(start: startHeading, current: current)
                
                if distanceAndDirection.isLeft {
                    if distanceAndDirection.difference > leftMax {
                        leftMax = distanceAndDirection.difference.roundTo(places: decPlaces)
                    }
                } else {
                    if distanceAndDirection.difference > rightMax {
                        rightMax = distanceAndDirection.difference.roundTo(places: decPlaces)
                    }
                }
                
                let leftMaxString = leftMax
                let rightMaxString = rightMax
                
                updateLabelDelegate?.updateHeadingLabel(with: distanceAndDirection.difference, left: leftMaxString, right: rightMaxString)
                
            }
        } else {
            
            if let startHeading = startHeading {
            let currentHeading = newHeading.magneticHeading.roundTo(places: 2)
            
            let distance = findDegreesAndDirection(start: startHeading, current: currentHeading)
            updateLabelDelegate?.updateHeadingLabel(with: distance.difference, left: nil, right: nil)
            
            }
        }
        
        
    }
    
    
    func findDegreesAndDirection(start: Double, current: Double) -> (difference: Double, isLeft: Bool) {
        
        var difference = abs(current - start).truncatingRemainder(dividingBy: 360)
        
        difference = difference > 180 ? (360 - difference) : difference
        
        
        var isLeft = true
        
        if start > 180 || start == 0 && current < 180 {
            let range = abs(start - 180).truncatingRemainder(dividingBy: 360)
            if current > start || current < range {
                isLeft = false
            }
        } else if start < 180 {
            if current < start + 180 && current > start {
                isLeft = false
            }
        }
        
        return (difference.roundTo(places: 2), isLeft)
        
    }
    
    func reset() {
        startHeading = nil
        minHeading = nil
        maxHeading = nil
        
        leftMax = 0.0
        rightMax = 0.0
        
        isShooting = false
    }
    
}


