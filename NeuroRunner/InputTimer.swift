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
    
    // TODO: InputMethod is tied to AGVM's didSet; will models deinitialize? should they be lazy vars?
    var inputMethod: InputMethod
    
    lazy var microphone = Microphone()
    
    init(inputMethod: InputMethod) {
        self.inputMethod = inputMethod
    }
    
}

extension InputTimer {
    
    func addTimeToTotalInput() {
        print("InputTimer input method = \(inputMethod)")
        switch inputMethod {
        case .Microphone:
            addUsingMicrophone()
        case .Gyroscope:
            break
            // TODO: Is this safe?
        case .manual:
            // No method here; manual input must be entered via the View's button
            break
        }
    }
    
    func clearTimer() {
        totalInputTime = 0.0
        if inputTimer != nil {
            inputTimer.invalidate()
        }
    }
    
    private func addUsingMicrophone() {
        print("microphone input")
        microphone.audioRecorder.record()
        inputTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
            self.totalInputTime = self.microphone.levelTimerCallback()
            print("total input time = \(self.totalInputTime)")
            
        }
    }
    
    func addUsingManual() {
        print("manual input")
        inputTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { (timer) in
            self.totalInputTime += 0.01
            print("total input time = \(self.totalInputTime)")
        }
    }
    
}
