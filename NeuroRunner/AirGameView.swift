//
//  AirGameView.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/22/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import SnapKit
import AudioKit

class AirGameView: UIView {
    
    var pickerView = UIPickerView()
    var startStopButton = UIButton()
    var timer = Timer()
    
    var microphoneAnalysis: MicrophoneAnalysis!
    var plot: AKNodeOutputPlot!
    var audioInputPlot = EZAudioPlot()

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
        
        startStopButton.titleLabel?.text = "Start"
        
        for number in 1...15 {
            pickerData.append(number)
        }
        
        microphoneAnalysis = MicrophoneAnalysis()
        
        plot = AKNodeOutputPlot(microphoneAnalysis.microphone, frame: audioInputPlot.bounds)
        plot.plotType = .rolling
        plot.shouldFill = true
        plot.shouldMirror = true
        plot.color = UIColor.blue
        
    }
    
    func constrain() {
        addSubview(pickerView)
        pickerView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().dividedBy(10)
            $0.centerX.centerY.equalToSuperview()
        }
        
        addSubview(audioInputPlot)
        audioInputPlot.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(2)
        }
        
        audioInputPlot.addSubview(plot)
        plot.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
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
