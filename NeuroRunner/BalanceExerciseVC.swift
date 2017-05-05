//
//  BalanceGameViewController.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/19/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

class BalanceExerciseVC: UIViewController {

    let balanceView = BalanceView()
    var balanceSummaryVC: BalanceSummaryVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        balanceView.balanceViewModel.presentGameSummaryDelegate = self
        
        view.addSubview(balanceView)
        balanceView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-49)        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension BalanceExerciseVC: PresentGameSummaryDelegate {
    
    func presentGameSummary() {
        print("should be presenting!")
        balanceSummaryVC = BalanceSummaryVC()
        
        balanceSummaryVC.providesPresentationContextTransitionStyle = true
        balanceSummaryVC.definesPresentationContext = true
        balanceSummaryVC.modalPresentationStyle = .overFullScreen
        self.present(balanceSummaryVC, animated: true, completion: nil)
        
    }
}
