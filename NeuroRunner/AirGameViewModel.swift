//
//  AirGameViewModel.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/27/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

final class AirGameViewModel {
    
    let store = DataStore.shared
    var user: User!
    
    var newExercise: BreathingExercise!
    let exerciseTimer = ExerciseTimer()
    var inputTimer: InputTimer!
    var inputMethod: InputMethod = .manual {
        didSet {
            inputTimer.inputMethod = self.inputMethod
        }
    }
    
    var timerDirection: Direction = .Down {
        didSet {
            exerciseTimer.direction = timerDirection
        }
    }
    
    var presentGameSummaryDelegate: PresentGameSummaryDelegate?
    
    init() {
        user = store.user
        inputTimer = InputTimer(inputMethod: inputMethod)
    }
}

// MARK: Game Methods
extension AirGameViewModel {
    
    func startExercise(with initialStartTime: Double?, countdownDirection: Direction) {
        
        if countdownDirection == .Down {
            if let initialStartTime = initialStartTime {
                exerciseTimer.totalTime = initialStartTime
                
                inputTimer.addTimeToTotalInput()
                
                exerciseTimer.startCountDownTimer(completion: {
                    self.createAirHungerGame(totalTime: initialStartTime)
                })
            }
        } else {
            inputTimer.addTimeToTotalInput()
        }
    }
    
    func cancelExercise() {
        exerciseTimer.clearTimer()
        inputTimer.clearTimer()
        
        if inputTimer.inputMethod == .Microphone {
            inputTimer.microphone.clearMicrophone()
        }
    }
    
    func createAirHungerGame(totalTime: Double) {
        newExercise = BreathingExercise()
        
        newExercise.timeSpentBreathing = inputTimer.totalInputTime.roundTo(places: 2)
        newExercise.timeSpentHungering = totalTime - inputTimer.totalInputTime.roundTo(places: 2)
        
        try! store.realm.write {
            user.airHungerGames.append(newExercise)
        }
        
        presentGameSummaryDelegate?.presentGameSummary()
             
        newExercise = nil
        cancelExercise()
    }
    
}


