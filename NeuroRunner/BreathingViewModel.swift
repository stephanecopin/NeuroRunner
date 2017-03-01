//
//  BreathingViewModel.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/27/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

protocol TakingBreathDelegate {
    
    func addToTimeBreathingButton(isBreathing: Bool)
    
    func addToTimeBreathingMicrophone()
    
}

class BreathingViewModel: TakingBreathDelegate {
    
    var timer: Timer!
    
    var timeBreathingButton = 0.0
    var timeBreathingMicrophone = 0.0
    var totalTimeBreathing: Double {
        get {
            return timeBreathingButton + timeBreathingMicrophone
        }
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
        print("timebreathing microphone = \(timeBreathingMicrophone)")
    }
    
    func addToTimeBreathingMicrophone() {
        timeBreathingMicrophone += 0.1
    }
    
}
