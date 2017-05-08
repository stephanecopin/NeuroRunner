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
    let pickerView = CustomPickerView()
    var timerView = CustomTimerLabel()
    var segmentedControl: CustomSegmentedControl!
    
    // Timer Hardware
    var isTimerOn = false
    let minLabel = UILabel()
    
    var timerDirection: Direction {
        if segmentedControl.selectedIndex == 0 {
            balanceViewModel.timerDirection = .Down
            timerView.timerDirection = .Down
            pickerView.isHidden = false
            print("down")
            return .Down
        } else {
            balanceViewModel.timerDirection = .Up
            timerView.timerDirection = .Up
            pickerView.isHidden = true
            print("up")
            return .Up
        }
    }
    
    // Exercise buttons
    let startStopButton = UIButton()
    lazy var breathingButton = UIButton() // TODO manual balance?

    // Background UI
    var backgroundImageView: UIImageView!
    
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
        
        let backgroundImage = #imageLiteral(resourceName: "Space")
        backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = backgroundImage
        
        segmentedControl = CustomSegmentedControl()
        segmentedControl.items = ["Count Down", "Count Up"]
        segmentedControl.selectedIndex = 1
        segmentedControl.addTarget(self, action: #selector(exerciseSelection(sender:)), for: .valueChanged)
        
        startStopButton.backgroundColor = UIColor.startButtonStart
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.setTitleColor(UIColor.themeWhite, for: .normal)
        startStopButton.setTitleShadowColor(UIColor.green, for: .normal)
        startStopButton.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 36)
        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        
        minLabel.text = "  minutes"
        minLabel.font = UIFont(name: "AvenirNext-Regular", size: 30)
        minLabel.textColor = UIColor.white

    }
    
    func constrain() {
        addSubview(backgroundImageView)
        
        addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(85)
            $0.width.equalToSuperview().multipliedBy(0.75)
            $0.height.equalToSuperview().dividedBy(15)
        }
        
        addSubview(timerView)
        timerView.snp.makeConstraints {
            $0.width.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(10)
            $0.top.equalTo(segmentedControl.snp.bottom).offset(10)
        }
        
        addSubview(pickerView)
        pickerView.snp.makeConstraints {
            $0.width.equalToSuperview().dividedBy(7)
            $0.height.equalToSuperview().dividedBy(7)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(self.snp.centerX)
        }
        
        addSubview(minLabel)
        minLabel.snp.makeConstraints {
            $0.centerY.equalTo(pickerView.snp.centerY)
            $0.leading.equalTo(pickerView.snp.trailing)
        }
        
        addSubview(startStopButton)
        startStopButton.snp.makeConstraints {
            $0.bottom.width.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(10)
        }
        
    }
}

extension BalanceView {
    
    func exerciseSelection(sender: CustomSegmentedControl) {

        if segmentedControl.selectedIndex == 0 {
            balanceViewModel.timerDirection = .Down
            timerView.timerDirection = .Down
            pickerView.isHidden = false
            minLabel.isHidden = false
        } else {
            balanceViewModel.timerDirection = .Up
            timerView.timerDirection = .Up
            pickerView.isHidden = true
            minLabel.isHidden = true
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
        pickerView.isHidden = true
        minLabel.isHidden = true
        
        startStopButton.setTitle("Stop", for: .normal)
        startStopButton.backgroundColor = UIColor.startButtonStop
        
        timerView.timerOn()
        
    }
    
    func timerOff() {
        timerView.timerOff()
        
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.backgroundColor = UIColor.startButtonStart

        
        pickerView.isHidden = false
        minLabel.isHidden = false
        isTimerOn = false
        
    }
    
}
