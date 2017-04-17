//
//  AirGameViewModel.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/27/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

class AirGameViewModel {
    
    let store = DataStore.shared
    var user: User!
    
    var timer: Timer!
    var newExercise: BreathingExercise!
    let exerciseTimer = ExerciseTimer()
    
    var presentGameSummaryDelegate: PresentGameSummaryDelegate?
    
    var isManualInput = true
    var timeBreathingButton = 0.00
    var timeBreathingInput = 0.00
    // TODO: should not combine; one or the other
    // To make sure that microphone and button are not duplicating information
    
    init() {
        user = store.user
    }
    
    func startExercise(with initialStartTime: Double?) {
        
        if let initialStartTime = initialStartTime {
            exerciseTimer.countdownTime = initialStartTime
            exerciseTimer.startPrimaryTimer(completion: {
                // When countdownTimer == 0; completion:
                self.createAirHungerGame(totalTime: initialStartTime)
            })

            // set up input timer
            
        }
        
    }
    
    func cancelExercise() {
        exerciseTimer.primaryTimer.invalidate()
//        customTimer.inputTimer.invalidate()
        timeBreathingButton = 0.00
        timeBreathingInput = 0.00
    }
    
    func createAirHungerGame(totalTime: Double) {
        print("creating!!!")
        newExercise = BreathingExercise()
        
        if isManualInput {
            newExercise.timeSpentBreathing = timeBreathingButton.roundTo(places: 2)
            newExercise.timeSpentHungering = totalTime - timeBreathingButton.roundTo(places: 2)
        } else {
            newExercise.timeSpentBreathing = timeBreathingInput.roundTo(places: 2)
            newExercise.timeSpentHungering = totalTime - timeBreathingInput.roundTo(places: 2)
        }
        
        try! store.realm.write {
            user.airHungerGames.append(newExercise)
        }
        
        presentGameSummaryDelegate?.presentGameSummary()

        print("User airGame count is \(user.airHungerGames.count)")
        print("Date = \(newExercise.dateOfExercise)")
        print("time breathing = \(newExercise.timeSpentBreathing)")
        print("time hungering = \(newExercise.timeSpentHungering)")
        print("total time = \(totalTime)")
        print("newGame returned to nil")
        
        newExercise = nil
        timeBreathingButton = 0.00
        timeBreathingInput = 0.00
        
    }
    
}

// MARK: Input timer methods
extension AirGameViewModel {
    
    // TODO: combine these to functions; get to correspond directly to input button and/or microphone
    func addToTimeBreathingButton(isBreathing: Bool) {
        
        if isBreathing {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
                self.timeBreathingButton += 0.01
            }
        } else {
            timer.invalidate()
        }
    }
    
    func addToTimeBreathingMicrophone() {
        timeBreathingInput += 0.01
        
        
    }
}
