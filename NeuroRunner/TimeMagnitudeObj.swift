//
//  MagnitudeTime.swift
//  NeuroRunner
//
//  Created by Robert Deans on 5/4/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import RealmSwift

// TODO: This is a work around to write primitive arrays to Realm

class TimeMagnitudeObj: Object {
    
    let magnitudes = List<DoubleObj>()
    let timeIntervals = List<DoubleObj>()
    
}

class DoubleObj: Object {
    dynamic var value = 0.0
}
