//
//  CustomTimer.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/14/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

// Class associated with overall time of exercise; measured counting up from zero or counting down from set time

class ExerciseTimer {
    
    var primaryTimer: Timer!
    var direction: Direction = .Down
    var totalTime = 0.0
    
}

extension ExerciseTimer {
    
    func startCountDownTimer(completion: @escaping () -> ()) {
        primaryTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.totalTime -= 1
            if self.totalTime == 0.0 {
                self.primaryTimer.invalidate()
                completion()
            }
        })
    }
    
    func startCountUpTimer() {
        primaryTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.totalTime += 1
        })
    }
    
    func clearTimer() {
        totalTime = 0.0
        if primaryTimer != nil {
            primaryTimer.invalidate()
        }
    }
    
}
