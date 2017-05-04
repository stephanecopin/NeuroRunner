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
    var intervalTimer = IntervalTimer()
    
    init() {
        user = store.user
    }
    
    
}

extension BalanceViewModel {
  
    func startExercise() {
    
        intervalTimer.start()
    
    }
    
    func cancelExercise() {

        intervalTimer.stop()
        
    }

}
