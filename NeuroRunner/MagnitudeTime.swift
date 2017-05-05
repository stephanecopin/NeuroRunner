//
//  MagnitudeTime.swift
//  NeuroRunner
//
//  Created by Robert Deans on 5/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import RealmSwift

// TODO: This is a work around for an array of primitives

class MagnitudeTime: Object {
    
    let magnitudes = List<DoubleObj>()
    let timeIntervals = List<DoubleObj>()
    
}

class DoubleObj: Object {
    dynamic var value = 0.0
    
//    convenience init(value: Double) {
//        self.init()
//        self.value = value
//    }
//    
//    required init() {
//        fatalError("init() has not been implemented")
//    }
}
