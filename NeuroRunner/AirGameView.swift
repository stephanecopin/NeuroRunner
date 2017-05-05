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
    
    // View Model
    let airGameViewModel = AirGameViewModel()
    
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
            airGameViewModel.timerDirection = .Down
            return .Down
        } else {
            airGameViewModel.timerDirection = .Up
            return .Up
        }
    }
    
    // Exercise buttons
    let startStopButton = UIButton()
    lazy var breathingButton = UIButton()
    var upDownSegmentedControl: UISegmentedControl!
    
    // Background UI
    var backgroundImageView: UIImageView!
    var blurView: UIVisualEffectView!
    
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
        airGameViewModel.inputTimer.microphone.sensorViewUpdateDelegate = self
        
        let items = ["Down", "Up"]
        upDownSegmentedControl = UISegmentedControl(items: items)
        upDownSegmentedControl.selectedSegmentIndex = 0
        
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
        blurView.alpha = 0.4
        
        let backgroundImage = #imageLiteral(resourceName: "mountain")
        backgroundImageView = UIImageView(frame: CGRect(origin: CGPoint.init(x: -745, y: 0), size: backgroundImage.size))
        backgroundImageView.image = backgroundImage
        
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
        breathingButton.addTarget(self, action: #selector(takeBreathManualInput(_:)), for: .touchDown)
        breathingButton.addTarget(self, action: #selector(releaseBreathManualInput(_:)), for: .touchUpInside)
        
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
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(blurView)
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
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
    
    // Only Start/Stop Button can begin or cancel Exercise via ViewModel
    func startStopButtonTapped() {
        isTimerOn = !isTimerOn
        
        if isTimerOn {
            timerOn()
            airGameViewModel.startExercise(with: Double(totalTime), countdownDirection: timerDirection)
        } else {
            timerOff()
            if timerDirection == .Up {
                airGameViewModel.createAirHungerGame(totalTime: Double(totalTime))
            }
            airGameViewModel.cancelExercise()
        }
    }
    
    func timerOn() {
        isTimerOn = true
        
        if timerDirection == .Up {
            totalTime = 0
            customTimerView.timerPicker.selectRow(customTimerView.pickerDataSize/2, inComponent: 0, animated: false)
            customTimerView.timerPicker.selectRow(customTimerView.pickerDataSize/2, inComponent: 1, animated: false)
        } else {
            let minuteData = Int(customTimerView.timerPicker.selectedRow(inComponent: 0) % 60)
            let secondData = Int(customTimerView.timerPicker.selectedRow(inComponent: 1) % 60)
            totalTime = (minuteData * 60) + (secondData)
        }
        
        viewTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
        
        if airGameViewModel.inputTimer.inputMethod == .manual {
            breathingButton.isHidden = false
        }
        customTimerView.isHidden = true
        
        startStopButton.setTitle("Stop", for: .normal)
        startStopButton.backgroundColor = UIColor.startButtonStop
    }
    
    func timerOff() {
        viewTimer.invalidate()
        
        breathingButton.isHidden = true
        customTimerView.isHidden = false
        
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.backgroundColor = UIColor.startButtonStart
        
        secondsLabel.text = "00"
        minutesLabel.text = "00:"
        
        blurView.alpha = 0.4
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
    
    func takeBreathManualInput(_ sender: UIButton) {
        sender.backgroundColor = UIColor.breathingButtonOn
        blurView.alpha = 0
        
        airGameViewModel.inputTimer.addUsingManual()
        // Does not handle data, only provides stimulus for input
    }
    
    func releaseBreathManualInput(_ sender: UIButton) {
        sender.backgroundColor = UIColor.breathingButtonOff
        blurView.alpha = 0.4
        if let timer = airGameViewModel.inputTimer.inputTimer {
            timer.invalidate()
        }
        // Does not handle/alter data, only ends timer
    }
    
}

extension AirGameView: SensorViewUpdateDelegate {
    
    // Strictly for visual cues
    func sensoryInputDetected(_ isDetected: Bool) {
        if isDetected {
            blurView.alpha = 0
        } else {
            blurView.alpha = 0.4
        }
    }
    
}
