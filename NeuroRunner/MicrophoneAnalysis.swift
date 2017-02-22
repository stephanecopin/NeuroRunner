//
//  MicrophoneAnalysis.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/22/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import AudioKit

class MicrophoneAnalysis {
    
    var microphone: AKMicrophone!
    var tracker: AKFrequencyTracker!
    var silence: AKBooster!
    var plot: AKNodeOutputPlot!
    
    init() {
        microphone = AKMicrophone()
        tracker = AKFrequencyTracker(microphone, hopSize: 512, peakCount: 20)
        silence = AKBooster(tracker, gain: 0)
        plot = AKNodeOutputPlot(microphone, frame: .zero)
        plot.plotType = .rolling
        plot.shouldFill = true
        plot.shouldMirror = true
        plot.color = UIColor.blue
        
    }
    
    
    
}
