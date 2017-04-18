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
    lazy var gyroscope = Gyroscope()
    
    init(inputMethod: InputMethod) {
        self.inputMethod = inputMethod
    }
    
}

extension InputTimer {
    
    func addTimeToTotalInput() {
        print("input method = \(inputMethod)")
        switch inputMethod {
        case .Microphone:
            addUsingMicrophone()
        case .Gyroscope:
            addUsingGyroscope()
        case .manual:
//            addUsingManual()
            break
        }
    }
    
    func clearTimer() {
        inputTimer.invalidate()
        totalInputTime = 0.0
    }
    
    func addUsingMicrophone() {
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
    
    func addUsingGyroscope() {
        
    }
    
}
