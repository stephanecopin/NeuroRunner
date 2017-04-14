//
//  User.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/22/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import RealmSwift

class User: Object {
    
    dynamic var name = ""
    let airHungerGames = List<BreathingExercise>()
    
}
