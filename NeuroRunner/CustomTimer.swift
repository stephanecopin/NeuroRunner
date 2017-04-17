//
//  CustomTimer.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/14/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

class ExerciseTimer {
    
    enum CountUpDown {
        case up, down
    }
    
    var primaryTimer: Timer!
    // Primary timer should count up and/or count down
    var countdownTime = 0.0
    
    var inputTimer: InputTimer!
    // Input timer should count up
    // Is input for game manual or automatic (microphone)
    
    var exercise: Exercise?

}

extension ExerciseTimer {
    
    
    func startPrimaryTimer(completion: @escaping () -> ()) {
        primaryTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.countdownTime -= 5
            if self.countdownTime == 0.0 {
                self.primaryTimer.invalidate()
                completion()
            }
        })
        
    }
    
    @objc func removeTimeFromPrimaryTimer() {
        countdownTime -= 5
        print("countdown time = \(countdownTime)")
        if countdownTime == 0.0 {
            primaryTimer.invalidate()
        }
    }
    
    @objc func addTimeToPrimaryTimer() {
        countdownTime += 1
    }
    
    
}
