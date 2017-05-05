//
//  BalanceExerciseSummaryVC.swift
//  NeuroRunner
//
//  Created by Robert Deans on 5/5/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

class BalanceExerciseSummaryVC: UIViewController {
    
    let store = DataStore.shared
    var user: User!
    var balanceExerciseSummaryView: BalanceExerciseSummaryView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = store.user
        
        if user.balanceExercises.count > 0, let lastGame = user.balanceExercises.last {
            
            balanceExerciseSummaryView = BalanceExerciseSummaryView(with: lastGame)
            
            view.addSubview(balanceExerciseSummaryView)
            balanceExerciseSummaryView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
            balanceExerciseSummaryView.dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
            
        }
        
    }
    
    func dismissView() {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
