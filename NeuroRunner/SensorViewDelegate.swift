//
//  SensorViewDelegate.swift
//  NeuroRunner
//
//  Created by Robert Deans on 5/2/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

// Used to guve visual cues when microphone detects breathing

protocol SensorViewUpdateDelegate {
    
    func sensoryInputDetected(_ isDetected: Bool)
    
}
