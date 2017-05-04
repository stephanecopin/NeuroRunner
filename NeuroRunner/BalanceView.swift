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
    
    let startStopButton = UIButton()
    var isTimerOn = false

    
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
//        balanceViewModel.inputTimer.gyroscope.start()
        
        startStopButton.backgroundColor = UIColor.startButtonStart
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.setTitleColor(UIColor.themeWhite, for: .normal)
        startStopButton.setTitleShadowColor(UIColor.green, for: .normal)
        startStopButton.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 36)
        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)

    }
    
    func constrain() {
        addSubview(startStopButton)
        startStopButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
    func startStopButtonTapped() {
        isTimerOn = !isTimerOn
        
        if isTimerOn {
            timerOn()

            
        } else {
            timerOff()

            
        }
    }
    
    func timerOn() {
        isTimerOn = true
        
        startStopButton.setTitle("Stop", for: .normal)
        startStopButton.backgroundColor = UIColor.startButtonStop
        
        balanceViewModel.startExercise()
    }
    
    func timerOff() {
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.backgroundColor = UIColor.startButtonStart

        isTimerOn = false
        
        balanceViewModel.cancelExercise()
    }
    
}
