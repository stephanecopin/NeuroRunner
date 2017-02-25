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
    var startStopButton = UIButton()
    var timerLabel = UILabel()
    
    var timer = Timer()
    var seconds = 0
    var isTimerOn = false
    
    var pickerData = [Int]()
    
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
        pickerView.delegate = self
        pickerView.dataSource = self
        
        for number in 1...15 {
            pickerData.append(number)
        }
        
        startStopButton.setTitle("Start", for: .normal)
        startStopButton.setTitleColor(UIColor.blue, for: .normal)
        startStopButton.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 36)
        startStopButton.backgroundColor = UIColor.green
        startStopButton.addTarget(self, action: #selector(startStopButtonTapped), for: .touchUpInside)
        
        timerLabel.backgroundColor = UIColor.orange
        timerLabel.font = UIFont(name: "Verdana", size: 16)
        timerLabel.text = "0"
        timerLabel.textAlignment = .center

    }
    
    func constrain() {
        addSubview(pickerView)
        pickerView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().dividedBy(10)
            $0.centerX.centerY.equalToSuperview()
        }
        
        addSubview(startStopButton)
        startStopButton.snp.makeConstraints {
            $0.bottom.width.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(10)
        }
        
        addSubview(timerLabel)
        timerLabel.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(10)
            $0.bottom.equalTo(pickerView.snp.top).offset(-20)
        }
        
        
    }
    
    func startStopButtonTapped() {
        print("start/stop tapped")
        isTimerOn = !isTimerOn
        print(isTimerOn)
        
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
        seconds += 1
        timerLabel.text = "\(seconds)"
        print("update timer \(seconds)")
    }
    
}

extension AirGameView: UIPickerViewDelegate, UIPickerViewDataSource {
 
    // MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerData[row])"
    }
    
}
