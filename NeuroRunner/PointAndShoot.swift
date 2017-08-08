//
//  PointAndShoot.swift
//  NeuroRunner
//
//  Created by Robert Deans on 8/7/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import RealmSwift
import CoreLocation


// TODO: Convert magnetic heading to more accurately describe mins and maxs (setting a new point Zero)

class PointAndShoot: NSObject {
    
    let manager = DataStore.shared.user.locationManager
    
    var startHeading: CLHeading?
    var minHeading: CLHeading?
    var maxHeading: CLHeading?
    
    var leftMax = 0.0
    var rightMax = 0.0
    
    var updateLabelDelegate: UpdateLabelDelegate?
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
        if let currentHeading = manager.heading {
            startHeading = currentHeading
        }
    }
    
    // TODO: Clean this up
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        
        if isShooting == false {
            
            
            if let minHeading = minHeading, let maxHeading = maxHeading {
                let currentString = "\(newHeading.magneticHeading.roundTo(places: decPlaces))"
                let minString = "\(minHeading.magneticHeading.roundTo(places: decPlaces))"
                let maxString = "\(maxHeading.magneticHeading.roundTo(places: decPlaces))"
                
                updateLabelDelegate?.updateHeadingLabel(with: currentString, left: minString, right: maxString)
                
            }
        }
        
        
        
        if isShooting {
            
            let current = Double(newHeading.magneticHeading)
            
            if let startHeading = startHeading {
                let start = Double(startHeading.magneticHeading)
                
                let distanceAndDirection = findDegreesAndDirection(start: start, current: current)
                
                if distanceAndDirection.isLeft {
                    leftMax = distanceAndDirection.difference.roundTo(places: decPlaces)
                } else {
                    rightMax = distanceAndDirection.difference.roundTo(places: decPlaces)
                }
             
                let currentString = "\(newHeading.magneticHeading.roundTo(places: decPlaces))"
                let leftMaxString = "\(leftMax)"
                let rightMaxString = "\(rightMax)"
                
                updateLabelDelegate?.updateHeadingLabel(with: currentString, left: leftMaxString, right: rightMaxString)
                
            }
        } else {
            let currentString = "\(newHeading.magneticHeading.roundTo(places: decPlaces))"
            
            updateLabelDelegate?.updateHeadingLabel(with: currentString, left: nil, right: nil)
        }
        
    }
    
    
    func findDegreesAndDirection(start: Double, current: Double) -> (difference: Double, isLeft: Bool) {
        
        var minMaxBool = (0.0 ,false)
        
        let difference = abs(current - start).truncatingRemainder(dividingBy: 360)
        
        minMaxBool = difference > 180 ? (360 - difference, false) : (difference, true)
        
        return minMaxBool
        
    }
    
}


