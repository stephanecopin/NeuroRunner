//
//  AirGameViewModel.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/27/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

protocol TakingBreathDelegate {
    
    func addToTimeBreathingButton(isBreathing: Bool)
    
    func addToTimeBreathingMicrophone()
    
    func createAirHungerGame(totalTime: Double)

    
}

class AirGameViewModel: TakingBreathDelegate {
    
    let store = DataStore.shared
    var user: User!
    
    var timer: Timer!
    var newExercise: BreathingExercise!
    let customTimer = ExerciseTimer()
    
    var presentGameSummaryDelegate: PresentGameSummaryDelegate?
    
    var timeBreathingButton = 0.00
    var timeBreathingMicrophone = 0.00
    var totalTimeBreathing: Double {
        get {
            return timeBreathingButton + timeBreathingMicrophone
        }
    }
    
    // TODO: Make sure that microphone and button are not duplicating information
        
    init() {
        user = store.user
    }
    
    func startExercise() {
        // set up countdown timer?
        // set up input timer
        
        
        
    }
    
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
        timeBreathingMicrophone += 0.01
    }
    
    func createAirHungerGame(totalTime: Double) {
        
        newExercise = BreathingExercise()
        newExercise.timeSpentBreathing = totalTimeBreathing.roundTo(places: 2)
        newExercise.timeSpentHungering = totalTime - totalTimeBreathing.roundTo(places: 2)

        try! store.realm.write {
            user.airHungerGames.append(newExercise)
        }
        
        print("VM user airGame count is \(user.airHungerGames.count)")
        presentGameSummaryDelegate?.presentGameSummary()
        
        print("Date = \(newExercise.dateOfExercise)")
        print("time breathing microphone = \(timeBreathingMicrophone)")
        print("time breathing button = \(timeBreathingButton.roundTo(places: 2))")
        print("time hungering = \((totalTime - timeBreathingButton).roundTo(places: 2))")

        print("total time = \(totalTime)")
        print("newGame returned to nil")
        
        newExercise = nil
        timeBreathingButton = 0.00
        timeBreathingMicrophone = 0.00
        

    }
    
}
