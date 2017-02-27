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
    
    var pickerView = UIPickerView()
    var pickerTimer: UIDatePicker!
    var startStopButton = UIButton()
    var secondsLabel = UILabel()
    var minutesLabel = UILabel()
    
    var timerView = UIView()
    
    var timer = Timer()
    var seconds = 0
    var isTimerOn = false
    
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

        pickerTimer = UIDatePicker()
        pickerTimer.datePickerMode = .countDownTimer
        
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.setTitleColor(UIColor.blue, for: .normal)
        startStopButton.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 36)
        startStopButton.backgroundColor = UIColor.green
        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)

        secondsLabel.font = UIFont(name: "Verdana", size: 16)
        secondsLabel.text = "00"
        secondsLabel.textAlignment = .center
        secondsLabel.adjustsFontSizeToFitWidth = true
        
        minutesLabel.font = UIFont(name: "Verdana", size: 16)
        minutesLabel.text = "00:"
        minutesLabel.textAlignment = .center
        minutesLabel.adjustsFontSizeToFitWidth = true
        
        timerView.backgroundColor = UIColor.orange

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
        print("start/stop tapped")
        isTimerOn = !isTimerOn
        print(isTimerOn)
        
        seconds = Int(pickerTimer.countDownDuration)
        
        
        
        if isTimerOn {

            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            startStopButton.titleLabel?.text = "Stop"
            startStopButton.setTitleColor(UIColor.white, for: .normal)
            startStopButton.backgroundColor = UIColor.red
        } else {
            timer.invalidate()
            startStopButton.titleLabel?.text = "Start"
            startStopButton.setTitleColor(UIColor.blue, for: .normal)
            startStopButton.backgroundColor = UIColor.green

        }
    }
    
    func updateTimer() {
        seconds -= 1
        secondsLabel.text = "\(seconds)"
        print("update timer \(seconds)")
    }
    
}
