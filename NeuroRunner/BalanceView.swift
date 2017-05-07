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
    
    // View Model
    let balanceViewModel = BalanceViewModel()
    
    // Timer UI Elements
    let customTimerView = TimerView()
    var timerLabelView = UIView()
    
    var secondsLabel = UILabel() {
        didSet {
            secondsLabel.text = "\(seconds)"
            if 0...9 ~= seconds {
                secondsLabel.text = "0\(seconds)"
            }
        }
    }
    var minutesLabel = UILabel() {
        didSet {
            minutesLabel.text = "\(minutes):"
            if minutes == 0 {
                minutesLabel.text = "00:"
            }
        }
    }
    
    // Timer Hardware
    var viewTimer = Timer()
    var isTimerOn = false
    
    var totalTime = 0
    var seconds: Int {
        get {
            return (totalTime % 60)
        }
    }
    var minutes: Int {
        get {
            return (totalTime / 60)
        }
    }
    
    var timerDirection: Direction {
        if upDownSegmentedControl.selectedSegmentIndex == 0 {
            balanceViewModel.timerDirection = .Down
            return .Down
        } else {
            balanceViewModel.timerDirection = .Up
            return .Up
        }
    }
    
    // Exercise buttons
    let startStopButton = UIButton()
    lazy var breathingButton = UIButton() // TODO manual balance?
    var upDownSegmentedControl: UISegmentedControl!

    
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

        let items = ["Down", "Up"]
        upDownSegmentedControl = UISegmentedControl(items: items)
        upDownSegmentedControl.selectedSegmentIndex = 1
        
        startStopButton.backgroundColor = UIColor.startButtonStart
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.setTitleColor(UIColor.themeWhite, for: .normal)
        startStopButton.setTitleShadowColor(UIColor.green, for: .normal)
        startStopButton.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 36)
        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        
        secondsLabel.font = UIFont(name: "AvenirNext-UltraLight", size: 75)
        secondsLabel.textColor = UIColor.white
        secondsLabel.text = "00"
        secondsLabel.textAlignment = .center
        secondsLabel.adjustsFontSizeToFitWidth = true
        
        minutesLabel.font = UIFont(name: "AvenirNext-UltraLight", size: 75)
        minutesLabel.textColor = UIColor.white
        minutesLabel.text = "00:"
        minutesLabel.textAlignment = .center
        minutesLabel.adjustsFontSizeToFitWidth = true
        
        addSubview(timerLabelView)
        timerLabelView.snp.makeConstraints {
            $0.width.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(10)
            $0.centerY.equalToSuperview().offset(-180)
        }
        
        timerLabelView.addSubview(minutesLabel)
        minutesLabel.snp.makeConstraints {
            $0.top.bottom.height.equalToSuperview()
            $0.trailing.equalTo(timerLabelView.snp.centerX).offset(10)
        }
        
        timerLabelView.addSubview(secondsLabel)
        secondsLabel.snp.makeConstraints {
            $0.top.bottom.height.equalToSuperview()
            $0.leading.equalTo(timerLabelView.snp.centerX).offset(10)
        }
    }
    
    func constrain() {

        addSubview(customTimerView)
        customTimerView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().dividedBy(10)
            $0.centerX.centerY.equalToSuperview()
        }
        
        addSubview(upDownSegmentedControl)
        upDownSegmentedControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(customTimerView.snp.bottom).offset(25)
        }
        
        addSubview(startStopButton)
        startStopButton.snp.makeConstraints {
            $0.bottom.width.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(10)
        }
        
    }
    
    func startStopButtonTapped() {
        isTimerOn = !isTimerOn
        
        if isTimerOn {
            timerOn()
            
            balanceViewModel.startExercise()
            
        } else {
            timerOff()
            
            balanceViewModel.cancelExercise()

            
        }
    }
    
    func timerOn() {
        isTimerOn = true
        
        startStopButton.setTitle("Stop", for: .normal)
        startStopButton.backgroundColor = UIColor.startButtonStop
        
        viewTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
        
        customTimerView.isHidden = true
        
    }
    
    func timerOff() {
        viewTimer.invalidate()
        
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.backgroundColor = UIColor.startButtonStart
        
        secondsLabel.text = "00"
        minutesLabel.text = "00:"
        
        customTimerView.isHidden = false
        isTimerOn = false
        
    }
    
    func updateTimerLabel() {
        
        if timerDirection == .Down {
            totalTime -= 5
        } else {
            totalTime += 5
        }
        
        // TODO: Remaining logic should be didSet
        secondsLabel.text = "\(seconds)"
        minutesLabel.text = "\(minutes):"
        if 0...9 ~= seconds {
            secondsLabel.text = "0\(seconds)"
        }
        if minutes == 0 {
            minutesLabel.text = "00:"
        }
        
        if totalTime == 0 {
            timerOff()
        }
    }
    
}
