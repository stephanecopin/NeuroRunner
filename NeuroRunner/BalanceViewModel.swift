//
//  BalanceViewModel.swift
//  NeuroRunner
//
//  Created by Robert Deans on 5/1/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation

final class BalanceViewModel {
    
    let store = DataStore.shared
    var user: User!
    
    var balanceExercise: BalanceExercise!
    let exerciseTimer = ExerciseTimer()
    var inputTimer: InputTimer!
    var inputMethod: InputMethod = .manual {
        didSet {
            inputTimer.inputMethod = self.inputMethod
        }
    }
    
    
    init() {
        user = store.user
        inputTimer = InputTimer(inputMethod: inputMethod)
    }
    
    
}
