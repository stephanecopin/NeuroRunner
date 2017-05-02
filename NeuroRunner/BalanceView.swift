//
//  BalanceView.swift
//  NeuroRunner
//
//  Created by Robert Deans on 5/1/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

class BalanceView: UIView {
    
    let balanceViewModel = BalanceViewModel()
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constrain()
    }
    
    func configure() {
        backgroundColor = UIColor.cyan
        balanceViewModel.inputTimer.gyroscope.start()
    }
    
    func constrain() {
        
    }
    
}
