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
    var totalTime = 0.0
}

extension ExerciseTimer {
    
    
    func startCountDownTimer(completion: @escaping () -> ()) {
        primaryTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.totalTime -= 5
            if self.totalTime == 0.0 {
                self.primaryTimer.invalidate()
                completion()
            }
        })
    }
    
    func startCountUpTimer() {
        primaryTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.totalTime += 5
        })
    }
    
    func clearTimer() {
        totalTime = 0.0
        if primaryTimer != nil {
            primaryTimer.invalidate()
        }
    }
    
}
