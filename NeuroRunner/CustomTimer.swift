//
//  CustomTimer.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/14/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

class ExerciseTimer {
    
    var primaryTimer: Timer!
    // Primary timer should count up and/or count down
    var countdownTimer = 0.0
    
    var inputTimer: InputTimer!
    // Input timer should count up
    // Is input for game manual or automatic (microphone)
    
    var exercise: Exercise?
    
    
    init() {

    }

}

extension ExerciseTimer {
    
    
    func startPrimaryTimer() {
        primaryTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(doSomething), userInfo: nil, repeats: true)
        
    }
    
    @objc func doSomething() {
        
    }
    
    
    
}
