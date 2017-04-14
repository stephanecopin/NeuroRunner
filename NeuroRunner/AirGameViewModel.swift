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
    var newGame: BreathingExercise!
    
    let store = DataStore.shared
    var user: User!
    
    var presentGameSummaryDelegate: PresentGameSummaryDelegate?
    
    var timeBreathingButton = 0.00
    var timeBreathingMicrophone = 0.00
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
        
        newGame = BreathingExercise()
        newGame.timeSpentBreathing = totalTimeBreathing.roundTo(places: 2)
        newGame.timeSpentHungering = totalTime - totalTimeBreathing.roundTo(places: 2)

        try! store.realm.write {
            user.airHungerGames.append(newGame)
        }
        
        print("VM user airGame count is \(user.airHungerGames.count)")
        presentGameSummaryDelegate?.presentGameSummary()
        
        print("Date = \(newGame.dateOfExercise)")
        print("time breathing microphone = \(timeBreathingMicrophone)")
        print("time breathing button = \(timeBreathingButton.roundTo(places: 2))")
        print("time hungering = \((totalTime - timeBreathingButton).roundTo(places: 2))")

        print("total time = \(totalTime)")
        print("newGame returned to nil")
        
        newGame = nil
        timeBreathingButton = 0.00
        timeBreathingMicrophone = 0.00
        

    }
    
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
