//
//  InputTimer.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/14/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

class InputTimer {
    
    var inputTimer: Timer!
    var totalInputTime = 0.0

    var inputMethod: InputMethod = .manual {
        didSet {
            switch inputMethod {
            case .Microphone :
                microphone = Microphone()
            case .Gyroscope :
                gyroscope = Gyroscope()
            default: break
                // something
            }
        }
    }
    var microphone: Microphone?
    var gyroscope: Gyroscope?
    
}

extension InputTimer {
    

    
    func addTimeToPrimaryTimer() {
        inputTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.totalInputTime += 0.1
        })
    }
    
    func clearTimer() {
        inputTimer.invalidate()
        totalInputTime = 0.0
    }
    
}
