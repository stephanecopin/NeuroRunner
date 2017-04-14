//
//  BalanceExercise.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/14/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import RealmSwift


class BalanceExercise: Object {
    
    dynamic var timeSpentBalanced = 0.0
    dynamic var timeWobbling = 0.0
    dynamic var dateOfExercise: Date = Date()
    
}
