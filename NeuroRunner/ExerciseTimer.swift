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
    // should count up and/or count down
    var countdownTime = 0.0

}

// TODO: Program intervals?

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
    
    func clearTimer() {
        primaryTimer.invalidate()
        countdownTime = 0.0
    }
    
}
