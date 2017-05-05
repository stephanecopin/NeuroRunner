//
//  BalanceViewModel.swift
//  NeuroRunner
//
//  Created by Robert Deans on 5/1/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

final class BalanceViewModel {
    
    let store = DataStore.shared
    var user: User!
    
    var newExercise: BalanceExercise!
    let exerciseTimer = ExerciseTimer()
    var intervalTimer = IntervalTimer()
    
    init() {
        user = store.user
    }
    
    
}

extension BalanceViewModel {
  
    func startExercise() {
        exerciseTimer.direction = .Up
        exerciseTimer.startCountUpTimer()
        
        intervalTimer.start()
    
    }
    
    func cancelExercise() {

        createBreathingExercise()
        intervalTimer.stop()

    }
    
    func createBreathingExercise() {
        newExercise = BalanceExercise()
        print("breathing exercise created!")
        let magTim = MagnitudeTime()
        let magObjs = intervalTimer.gyroscope.magnitudes
        let timeObjs = intervalTimer.intervals
        
        for magnitude in magObjs {
            
            let magDoub = DoubleObj()
            magDoub.value = magnitude
            magTim.magnitudes.append(magDoub)
            
        }

        for time in timeObjs {
            
            let timeDoub = DoubleObj()
            timeDoub.value = time
            magTim.timeIntervals.append(timeDoub)
        }
        
        newExercise.magnitudeTimes = magTim
        
        try! store.realm.write {
            user.balanceExercises.append(newExercise)
            print("user has \(user.balanceExercises.count) balance exercises logged")
        }
        
        print("breathing exercise magitudes \(newExercise.magnitudeTimes?.magnitudes)")
        print("breathing exercise times \(newExercise.magnitudeTimes?.timeIntervals)")
        
        newExercise = nil
        
        
    }

}
