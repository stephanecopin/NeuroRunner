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
                let currentString = "\(newHeading.trueHeading.roundTo(places: decPlaces))"
                let minString = "\(minHeading.trueHeading.roundTo(places: decPlaces))"
                let maxString = "\(maxHeading.trueHeading.roundTo(places: decPlaces))"
                
                updateLabelDelegate?.updateHeadingLabel(with: currentString, left: minString, right: maxString)
                
            }
        }
        
        
        
        if isShooting {
            
            let current = Double(newHeading.trueHeading)
            
            if let startHeading = startHeading {
                let start = Double(startHeading.trueHeading)
                
                let distanceAndDirection = findDegreesAndDirection(start: start, current: current)
                
                print(distanceAndDirection)
                if distanceAndDirection.isLeft {
                    if distanceAndDirection.difference > leftMax {
                        leftMax = distanceAndDirection.difference.roundTo(places: decPlaces)
                    }
                } else {
                    if distanceAndDirection.difference > rightMax {
                        rightMax = distanceAndDirection.difference.roundTo(places: decPlaces)
                    }
                }
                
                let currentString = "\(newHeading.trueHeading.roundTo(places: decPlaces))"
                let leftMaxString = "\(leftMax)"
                let rightMaxString = "\(rightMax)"
                
                updateLabelDelegate?.updateHeadingLabel(with: currentString, left: leftMaxString, right: rightMaxString)
                
            }
        } else {
            let currentString = "\(newHeading.trueHeading.roundTo(places: decPlaces))"
            
            updateLabelDelegate?.updateHeadingLabel(with: currentString, left: nil, right: nil)
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
        
        return (difference, isLeft)
        
    }
    
}


