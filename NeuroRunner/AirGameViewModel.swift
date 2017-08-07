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
    let microphone = Microphone()
    let manualTimer = ManualTimer()
    
    var inputMethod: InputMethod = .manual
    
    var presentGameSummaryDelegate: PresentGameSummaryDelegate?
    
    init() {
        user = store.user
    }
}

// MARK: Game Methods
extension AirGameViewModel {
    
    func startExercise(with initialStartTime: Double?, countdownDirection: Direction) {
        
        if countdownDirection == .Down {
            if let initialStartTime = initialStartTime {
                
                if inputMethod == .manual {
                    // No .start() is required here since input is manual
                } else if inputMethod == .Microphone {
                    microphone.startTimer()
                }
                
                exerciseTimer.totalTime = initialStartTime
                
                exerciseTimer.startCountDownTimer(completion: {
                    self.createAirHungerGame(totalTime: initialStartTime)
                })
            }
        } else {
            // Timer is going Up
            if inputMethod == .manual {
                // No .start() is required here since input is manual
            } else if inputMethod == .Microphone {
                microphone.startTimer()
            }
        }
    }
    
    func cancelExercise() {
        exerciseTimer.clearTimer()
        manualTimer.reset()
        microphone.reset()
    }
    
    func createAirHungerGame(totalTime: Double) {
        newExercise = BreathingExercise()
        
        if inputMethod == .manual {
            newExercise.timeSpentBreathing = manualTimer.totalInputTime.roundTo(places: 2)
            newExercise.timeSpentHungering = totalTime - manualTimer.totalInputTime.roundTo(places: 2)
            
        } else if inputMethod == .Microphone {
            newExercise.timeSpentBreathing = microphone.totalInputTime.roundTo(places: 2)
            newExercise.timeSpentHungering = totalTime - microphone.totalInputTime.roundTo(places: 2)
        }
        
        
        try! store.realm.write {
            user.airHungerGames.append(newExercise)
            print("user now has \(user.airHungerGames.count) air hunger games exercises")
        }
        
        presentGameSummaryDelegate?.presentGameSummary()
             
        newExercise = nil
        cancelExercise()
    }
    
}


