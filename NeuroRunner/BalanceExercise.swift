//
//  BalanceExercise.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/14/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import RealmSwift


class BalanceExercise: Object {
    
    dynamic var magnitudeTimes: MagnitudeTime?
    dynamic var dateOfExercise: Date = Date()
    
}
