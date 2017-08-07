//
//  User.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/22/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import RealmSwift
import CoreMotion
import CoreLocation

class User: Object {
    
    dynamic var name = ""
    let airHungerGames = List<BreathingExercise>()
    let balanceExercises = List<BalanceExercise>()
    
    // IMPORTANT: An app should create only a single instance of the CMMotionManager class. Multiple instances of this class can affect the rate at which data is received from the accelerometer and gyroscope.
    
    let motionManager = CMMotionManager()
    
    let locationManager = (CLLocationManager())
    
}
