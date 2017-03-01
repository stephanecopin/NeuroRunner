//
//  AirGameView.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/22/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import SnapKit

class AirGameView: UIView {
    
    let pickerTimer = UIDatePicker()
    var timerView = UIView()
    var secondsLabel = UILabel()
    var minutesLabel = UILabel()
    
    var startStopButton = UIButton()
    var breathingButton = UIButton()
    
    var timer = Timer()
    var isTimerOn = false
    var totalTimeRemaining = 0
    var seconds = 0
    var minutes = 0
    
    var microphoneDelegate: MicrophoneDelegate?
    var takingBreathDelegate: TakingBreathDelegate?
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        configure()
        constrain()
    }
    
    func configure() {
        backgroundColor = UIColor.cyan
        timerView.backgroundColor = UIColor.orange

        pickerTimer.datePickerMode = .countDownTimer
        totalTimeRemaining = Int(pickerTimer.countDownDuration)
        
        startStopButton.backgroundColor = UIColor.green
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.setTitleColor(UIColor.blue, for: .normal)
        startStopButton.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 36)
        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)

        breathingButton.backgroundColor = UIColor.blue
        breathingButton.setTitle("Taking a Breath", for: .normal)
        breathingButton.setTitleColor(UIColor.white, for: .normal)
        breathingButton.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 28)
        breathingButton.addTarget(self, action: #selector(takeBreath(_:)), for: .touchDown)
        breathingButton.addTarget(self, action: #selector(releaseBreath(_:)), for: .touchUpInside)

        secondsLabel.font = UIFont(name: "Verdana", size: 20)
        secondsLabel.text = "00"
        secondsLabel.textAlignment = .center
        secondsLabel.adjustsFontSizeToFitWidth = true
        
        minutesLabel.font = UIFont(name: "Verdana", size: 20)
        minutesLabel.text = "00:"
        minutesLabel.textAlignment = .center
        minutesLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    func constrain() {
        addSubview(pickerTimer)
        pickerTimer.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().dividedBy(10)
            $0.centerX.centerY.equalToSuperview()
        }
        
        addSubview(startStopButton)
        startStopButton.snp.makeConstraints {
            $0.bottom.width.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(10)
        }
        
        addSubview(breathingButton)
        breathingButton.snp.makeConstraints {
            $0.height.equalToSuperview().dividedBy(10)
            $0.width.equalToSuperview().multipliedBy(0.75)
            $0.bottom.equalTo(startStopButton.snp.top).offset(-50)
            $0.centerX.equalToSuperview()
        }
        
        addSubview(timerView)
        timerView.snp.makeConstraints {
            $0.width.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(10)
            $0.centerY.equalToSuperview().offset(-200)
        }

        timerView.addSubview(minutesLabel)
        minutesLabel.snp.makeConstraints {
            $0.top.bottom.height.equalToSuperview()
            $0.trailing.equalTo(timerView.snp.centerX)
        }
        
        timerView.addSubview(secondsLabel)
        secondsLabel.snp.makeConstraints {
            $0.top.bottom.height.equalToSuperview()
            $0.leading.equalTo(timerView.snp.centerX)
        }
        
    }
    
    func startStopButtonTapped() {
        isTimerOn = !isTimerOn

        if isTimerOn {
            // Creates timer for label
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
            
            startStopButton.setTitle("Stop", for: .normal)
            startStopButton.setTitleColor(UIColor.white, for: .normal)
            startStopButton.backgroundColor = UIColor.red
            
            microphoneDelegate?.recordAudio(isRecording: true)

        } else {
            timer.invalidate()
            microphoneDelegate?.recordAudio(isRecording: false)

            startStopButton.setTitle("Start", for: .normal)
            startStopButton.setTitleColor(UIColor.blue, for: .normal)
            startStopButton.backgroundColor = UIColor.green
        }
    }
    
    func updateTimerLabel() {
        totalTimeRemaining -= 1
        minutes = (totalTimeRemaining / 60)
        seconds = totalTimeRemaining % 60
        
        secondsLabel.text = "\(seconds)"
        minutesLabel.text = "\(minutes):"
        
        if 0...9 ~= seconds {
            secondsLabel.text = "0\(seconds)"
        }
        
        if minutes == 0 {
            minutesLabel.text = "00:"
        }
        
        if totalTimeRemaining == 0 {
            timer.invalidate()
            microphoneDelegate?.recordAudio(isRecording: false)

            startStopButton.setTitle("Start", for: .normal)
            startStopButton.setTitleColor(UIColor.blue, for: .normal)
            startStopButton.backgroundColor = UIColor.green
        }
        print("time remaining = \(totalTimeRemaining)")

    }
    
    
    
    func takeBreath(_ sender: UIButton) {
        takingBreathDelegate?.addToTimeBreathingButton(isBreathing: true)
        sender.backgroundColor = UIColor.yellow
    }
    
    func releaseBreath(_ sender: UIButton) {
        sender.backgroundColor = UIColor.blue
        takingBreathDelegate?.addToTimeBreathingButton(isBreathing: false)
    }
    
}
