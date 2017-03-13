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
    var timerLabelView = UIView()
    var secondsLabel = UILabel()
    var minutesLabel = UILabel()
    
    var backgroundView: UIImageView!
    var blurView: UIVisualEffectView!
    
    var startStopButton = UIButton()
    var breathingButton = UIButton()
    
    var timer = Timer()
    var isTimerOn = false
    var initialStartTime = 0.0
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
        
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
        blurView.alpha = 0.4
        
        let backgroundImage = #imageLiteral(resourceName: "mountain")
        
        backgroundView = UIImageView(frame: CGRect(origin: CGPoint.init(x: -745, y: 0), size: backgroundImage.size))
        backgroundView.image = backgroundImage


        pickerTimer.datePickerMode = .countDownTimer
        
        startStopButton.backgroundColor = UIColor.startButtonStart
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.setTitleColor(UIColor.themeWhite, for: .normal)
        startStopButton.setTitleShadowColor(UIColor.green, for: .normal)
        startStopButton.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 36)
        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)

        breathingButton.backgroundColor = UIColor.breathingButtonOff
        breathingButton.layer.cornerRadius = 15
        breathingButton.layer.borderColor = UIColor.startButtonStart.cgColor
        breathingButton.layer.borderWidth = 1
        breathingButton.setTitle("Taking a Breath", for: .normal)
        breathingButton.setTitleColor(UIColor.white, for: .normal)
        breathingButton.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 28)
        breathingButton.isHidden = true
        breathingButton.addTarget(self, action: #selector(takeBreath(_:)), for: .touchDown)
        breathingButton.addTarget(self, action: #selector(releaseBreath(_:)), for: .touchUpInside)

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
        
    }
    
    func constrain() {
        addSubview(backgroundView)
        backgroundView.addSubview(blurView)
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
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
    
    func startStopButtonTapped() {
        isTimerOn = !isTimerOn

        if isTimerOn {
            timerOn()
        } else {
            timerOff()
        }
    }
    
    func timerOn() {
        
        totalTimeRemaining = Int(pickerTimer.countDownDuration)
        initialStartTime = Double(totalTimeRemaining)

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
        
        breathingButton.isHidden = false
        
        startStopButton.setTitle("Stop", for: .normal)
        startStopButton.backgroundColor = UIColor.startButtonStop
        
        microphoneDelegate?.recordAudio(isRecording: true)

    }
    
    func timerOff() {
        timer.invalidate()
        microphoneDelegate?.recordAudio(isRecording: false)
        
        breathingButton.isHidden = true
        
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.backgroundColor = UIColor.startButtonStart
        
        secondsLabel.text = "00"
        minutesLabel.text = "00:"
        
        blurView.alpha = 0.4

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
        
        // TIMER == 00:00 WILL CREATE INSTANCE OF GAME
        if totalTimeRemaining == 0 {
            timerOff()
            takingBreathDelegate?.createAirHungerGame(totalTime: initialStartTime)
        }
    }
    
    func takeBreath(_ sender: UIButton) {
        takingBreathDelegate?.addToTimeBreathingButton(isBreathing: true)
        sender.backgroundColor = UIColor.breathingButtonOn
        blurView.alpha = 0
    }
    
    func releaseBreath(_ sender: UIButton) {
        sender.backgroundColor = UIColor.breathingButtonOff
        blurView.alpha = 0.4
        takingBreathDelegate?.addToTimeBreathingButton(isBreathing: false)
    }

}

extension AirGameView: BreathingViewUpdate {
    
    func breathingDetected(isDetected: Bool) {
        if isDetected {
            blurView.alpha = 0
        } else {
            blurView.alpha = 0.4
        }
    }
    
}
