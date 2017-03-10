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
    
    var timer: Timer!
    var newGame: AirHungerGame!
    
    let store = DataStore.shared
    var user: User!
    
    var presentGameSummaryDelegate: PresentGameSummaryDelegate?
    
    var timeBreathingButton = 0.0
    var timeBreathingMicrophone = 0.0
    var totalTimeBreathing: Double {
        get {
            return timeBreathingButton + timeBreathingMicrophone
        }
    }
    
    // *** Make sure that microphone and button are not duplicating information
    
    // *** Delete any unnecessary instances of DataStore
    
    init() {
        user = store.user
    }
    
    
    func addToTimeBreathingButton(isBreathing: Bool) {
        
        if isBreathing {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { (timer) in
                
                self.timeBreathingButton += 0.1
                print("time spent breathing with button = \(self.timeBreathingButton) seconds")
                
            }
        } else {
            timer.invalidate()
        }
    }
    
    func addToTimeBreathingMicrophone() {
        timeBreathingMicrophone += 0.1
        print("time sprint breathing with microphone = \(timeBreathingMicrophone) seconds")
    }
    
    func createAirHungerGame(totalTime: Double) {
        newGame = AirHungerGame()
        newGame.timeSpentBreathing = totalTimeBreathing.roundTo(places: 2)
        newGame.timeSpentHungering = totalTime - totalTimeBreathing.roundTo(places: 2)

        user.airHungerGames.append(newGame)
        print("VM user airGame count is \(user.airHungerGames.count)")
        presentGameSummaryDelegate?.presentGameSummary()
        
        print("Date = \(newGame.dateOfExercise)")
        print("time breathing microphone = \(timeBreathingMicrophone)")
        print("time breathing button = \(timeBreathingButton)")
        print("newGame returned to nil")
        newGame = nil
        timeBreathingButton = 0.0
        timeBreathingMicrophone = 0.0

    }
    
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
