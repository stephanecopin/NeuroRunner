//
//  AirHungerGame.swift
//  NeuroRunner
//
//  Created by Robert Deans on 3/8/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import RealmSwift

class BreathingExercise: Object {
    
    dynamic var timeSpentBreathing = 0.0
    dynamic var timeSpentHungering = 0.0
    dynamic var dateOfExercise: Date = Date()
    
}
