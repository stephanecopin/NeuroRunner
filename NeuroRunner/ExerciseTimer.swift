//
//  CustomTimer.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/14/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
// TODO: Eventually will have capability to program intervals?

enum Direction {
    case Up, Down
}

class ExerciseTimer {

    
    var primaryTimer: Timer!
    var direction: Direction = .Down
    var countdownTime = 0.0
}

extension ExerciseTimer {
    
    
    func startCountDownTimer(completion: @escaping () -> ()) {
        primaryTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.countdownTime -= 5
            if self.countdownTime == 0.0 {
                self.primaryTimer.invalidate()
                completion()
            }
        })
        
    }
    
    // func startCountUpTimer() { }
    
    func clearTimer() {
        primaryTimer.invalidate()
        countdownTime = 0.0
    }
    
}
