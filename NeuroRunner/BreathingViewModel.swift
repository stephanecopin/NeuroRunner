//
//  BreathingViewModel.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/27/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

protocol TakingBreathDelegate {
    
    func takingBreath()
    
}

class BreathingViewModel: TakingBreathDelegate {
    
    var timeBreathing = 0
    var isTakingBreath = false
    
    func takingBreath() {
        isTakingBreath = !isTakingBreath
        print("\(isTakingBreath)")
        
        _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            
            if self.isTakingBreath {
                self.timeBreathing += 1
                print("\(self.timeBreathing)")
            } else {
                timer.invalidate()
            }
        }
    }
    
}
