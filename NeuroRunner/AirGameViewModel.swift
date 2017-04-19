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
    
    var newExercise: BreathingExercise!
    let exerciseTimer = ExerciseTimer()
    var inputTimer: InputTimer!
    // TODO: Make sure this works when input Method is changed
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

// MARK: ViewModel Methods
extension AirGameViewModel {
    
    func startExercise(with initialStartTime: Double?, countdownDirection: Direction) {
        // Optional because exercise may count up instead of down
        
        print("start exercise direction \(countdownDirection)")
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
        // Resets all timers and data
        
        if inputTimer.microphone.isMicrophoneEnabled {
            inputTimer.microphone.clearMicrophone()
        }
        
        exerciseTimer.clearTimer()
        inputTimer.clearTimer()
    }
    
    func createAirHungerGame(totalTime: Double) {
        newExercise = BreathingExercise()
        
        newExercise.timeSpentBreathing = inputTimer.totalInputTime.roundTo(places: 2)
        newExercise.timeSpentHungering = totalTime - inputTimer.totalInputTime.roundTo(places: 2)
        
        
        try! store.realm.write {
            user.airHungerGames.append(newExercise)
        }
        
        presentGameSummaryDelegate?.presentGameSummary()
        
        print("User airGame count is \(user.airHungerGames.count)")
        print("Date = \(newExercise.dateOfExercise)")
        print("time breathing = \(newExercise.timeSpentBreathing)")
        print("time hungering = \(newExercise.timeSpentHungering)")
        print("total time = \(totalTime)")
        
        newExercise = nil
        cancelExercise()
        
    }
    
}


