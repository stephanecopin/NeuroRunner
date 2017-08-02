//
//  CustomTimerLabel.swift
//  NeuroRunner
//
//  Created by Robert Deans on 5/8/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

class CustomTimerLabel: UIView {
    
    // UI Elements
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
    
    // Timer Elements
    var timer: Timer!
    var timerDirection: Direction = .Down
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
        addSubview(minutesLabel)
        minutesLabel.snp.makeConstraints {
            $0.top.bottom.height.equalToSuperview()
            $0.trailing.equalTo(self.snp.centerX).offset(10)
        }
        
        addSubview(secondsLabel)
        secondsLabel.snp.makeConstraints {
            $0.top.bottom.height.equalToSuperview()
            $0.leading.equalTo(self.snp.centerX).offset(10)
        }
    }
    
    func timerOn() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    func timerOff() {
        if let timer = timer {
            timer.invalidate()
        }
        totalTime = 0
        secondsLabel.text = "00"
        minutesLabel.text = "00:"
    }
    
    func updateTimerLabel() {
        
        if timerDirection == .Down {
            totalTime -= 1
        } else {
            totalTime += 1
        }
        
        secondsLabel.text = "\(seconds)"
        minutesLabel.text = "\(minutes):"
        if 0...9 ~= seconds {
            secondsLabel.text = "0\(seconds)"
        }
        if minutes == 0 {
            minutesLabel.text = "00:"
        }
        
        if totalTime <= 0 {
            timerOff()
        }
    }
    
}
