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
    
    var inputMethod: InputMethod {
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
    
    // TODO: Make this safer
    var microphone: Microphone!
    var gyroscope: Gyroscope!
    
    init(inputMethod: InputMethod) {
        self.inputMethod = inputMethod
    }
    
}

extension InputTimer {
    
    func addTimeToTotalInput(with inputMethod: InputMethod) {
        switch inputMethod {
        case .Microphone:
            totalInputTime = microphone.levelTimerCallback()
        case .Gyroscope: break
        // TODO: eventually will incorporate Gyroscope settings
        case .manual:
        inputTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
            self.totalInputTime += 0.01
            }
        }
    }
    
    func clearTimer() {
        inputTimer.invalidate()
        totalInputTime = 0.0
    }
    
}
