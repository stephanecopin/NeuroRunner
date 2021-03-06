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
//    var magnitudeTimer = MagnitudeTimer()
    
    let gyroscope = Gyroscope()
    
    var timerDirection: Direction = .Up
    
    var presentGameSummaryDelegate: PresentGameSummaryDelegate?

    
    init() {
        user = store.user
    }
    
    
}

extension BalanceViewModel {
  
    func startExercise() {
//        exerciseTimer.direction = .Up
//        exerciseTimer.startCountUpTimer()
        
        gyroscope.start()
    
    }
    
    func cancelExercise() {
        gyroscope.stop()

        createBreathingExercise()

        gyroscope.reset()

    }
    
    func createBreathingExercise() {
        newExercise = BalanceExercise()
        print("breathing exercise created!")

        let exerciseTimeMag = TimeMagnitudeObj()
        
        for timeMag in gyroscope.timeMagnitudes {
            let magDouble = DoubleObj()
            magDouble.value = timeMag.Magnitude
            
            let timeDouble = DoubleObj()
            timeDouble.value = timeMag.Time
            
            
            exerciseTimeMag.magnitudes.append(magDouble)
            exerciseTimeMag.timeIntervals.append(timeDouble)
            
            
        }
        
        newExercise.magnitudeTimes = exerciseTimeMag
        
        try! store.realm.write {
            user.balanceExercises.append(newExercise)
            print("user has \(user.balanceExercises.count) balance exercises logged")
        }
        
        presentGameSummaryDelegate?.presentGameSummary()
        
        newExercise = nil

        gyroscope.reset()
        
    }

}
