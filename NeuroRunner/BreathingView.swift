//
//  AirGameView.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/22/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import SnapKit

class BreathingView: UIView {
    
    // View Model
    let airGameViewModel = AirGameViewModel()
    
    // Timer UI Elements
    let pickerView = CustomPickerView()
    var timerView = CustomTimerLabel()
    var segmentedControl: CustomSegmentedControl!
    
    // Timer Hardware
    var isTimerOn = false
    let minLabel = UILabel()
    var localTimer: Timer!
    var localTime = 0.0
    
    var timerDirection: Direction = .Down {
        didSet {
            if timerDirection == .Down {
                timerView.timerDirection = .Down
                pickerView.isHidden = false
                minLabel.isHidden = false
            } else if timerDirection == .Up {
                timerView.timerDirection = .Up
                pickerView.isHidden = true
                minLabel.isHidden = true
            }
        }
    }
    
    // Exercise buttons
    let startStopButton = UIButton()
    lazy var breathingButton = UIButton()

    
    // Background UI
    var backgroundImageView: UIImageView!
    var blurView: UIVisualEffectView!
    
    // Info Text
    var infoTextView: UITextView!
    
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
        airGameViewModel.microphone.sensorViewUpdateDelegate = self
        
        segmentedControl = CustomSegmentedControl(items: ["Count Down", "Count Up"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(exerciseSelection(sender:)), for: .valueChanged)
        
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
        
        minLabel.text = "  minutes"
        minLabel.font = UIFont(name: "AvenirNext-Regular", size: 30)
        minLabel.textColor = UIColor.white
        
        infoTextView = UITextView()
        infoTextView.isEditable = false
        infoTextView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        infoTextView.textColor = UIColor.white
        infoTextView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
    
    func constrain() {
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(blurView)
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
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
            $0.top.equalTo(segmentedControl.snp.bottom).offset(15)
        }
        
        addSubview(pickerView)
        pickerView.snp.makeConstraints {
            $0.width.equalToSuperview().dividedBy(7)
            $0.height.equalToSuperview().dividedBy(7)
            $0.top.equalTo(timerView.snp.bottom).offset(15)
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
        
//        addSubview(infoTextView)
//        infoTextView.snp.makeConstraints {
//            $0.top.equalTo(pickerView.snp.bottom).offset(25)
//            $0.leading.equalToSuperview().offset(25)
//            $0.trailing.equalToSuperview().offset(-25)
//            $0.bottom.equalTo(startStopButton.snp.top).offset(-25)
//        }
        
        addSubview(breathingButton)
        breathingButton.snp.makeConstraints {
            $0.height.equalToSuperview().dividedBy(10)
            $0.width.equalToSuperview().multipliedBy(0.75)
            $0.bottom.equalTo(startStopButton.snp.top).offset(-50)
            $0.centerX.equalToSuperview()
        }
        
    }
}

extension BreathingView {

    func exerciseSelection(sender: CustomSegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            timerDirection = .Down
        } else if segmentedControl.selectedSegmentIndex == 1 {
            timerDirection = .Up
        }
    }
    
    // Only Start/Stop Button can begin or cancel Exercise via ViewModel
    func startStopButtonTapped() {
        isTimerOn = !isTimerOn
        
        if isTimerOn {
            timerOn()
            airGameViewModel.startExercise(with: Double(timerView.totalTime), countdownDirection: timerDirection)
        } else {
            if timerDirection == .Up {
                airGameViewModel.createAirHungerGame(totalTime: Double(timerView.totalTime))
            }
            airGameViewModel.cancelExercise()
            timerOff()
        }
    }
    
    func timerOn() {
        isTimerOn = true
        pickerView.isHidden = true
        minLabel.isHidden = true
        infoTextView.isHidden = true
        
        startStopButton.setTitle("Stop", for: .normal)
        startStopButton.backgroundColor = UIColor.startButtonStop
        
        if airGameViewModel.inputMethod == .manual {
            breathingButton.isHidden = false
        }
        
        if timerDirection == .Up {
            timerView.totalTime = 0
            localTimer = Timer(timeInterval: 1, repeats: true, block: { (timer) in
                self.localTime += 1
            })
        } else if timerDirection == .Down {
            let minuteData = Int(pickerView.timerPicker.selectedRow(inComponent: 0) % 60)
            timerView.totalTime = (minuteData * 60)
        }
        
        timerView.timerOn()
        pickerView.isHidden = true

    }
    
    func timerOff() {
        timerView.timerOff()
        breathingButton.isHidden = true
        infoTextView.isHidden = false
        
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.backgroundColor = UIColor.startButtonStart
        
        blurView.alpha = 0.4
        isTimerOn = false
        
        if timerDirection == .Down {
            pickerView.isHidden = false
            minLabel.isHidden = false
        } else {
            if let localTimer = localTimer {
                localTimer.invalidate()
            }
            pickerView.isHidden = true
            minLabel.isHidden = true
            localTime = 0.0
        }
    }
    
    func takeBreathManualInput(_ sender: UIButton) {
        sender.backgroundColor = UIColor.breathingButtonOn
        blurView.alpha = 0
        
        airGameViewModel.manualInputTimer.addUsingManual()
        // Does not handle data, only provides stimulus for input
    }
    
    func releaseBreathManualInput(_ sender: UIButton) {
        sender.backgroundColor = UIColor.breathingButtonOff
        blurView.alpha = 0.4
        if let timer = airGameViewModel.manualInputTimer.inputTimer {
            timer.invalidate()
        }
        // Does not handle/alter data, only ends timer
    }
    
}

extension BreathingView: SensorViewUpdateDelegate {
    
    // Strictly for visual cues
    func sensoryInputDetected(_ isDetected: Bool) {
        if isDetected {
            blurView.alpha = 0
        } else {
            blurView.alpha = 0.4
        }
    }
    
}
