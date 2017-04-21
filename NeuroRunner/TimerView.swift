//
//  TimerVier.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/21/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

class TimerView: UIView {

    
    let timerPicker = UIPickerView()
    var pickerData = [String]()
    let pickerDataSize = 6000
    
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
        backgroundColor = UIColor.white
        
        timerPicker.dataSource = self
        timerPicker.delegate = self
        
        for number in 0...59 {
            var numString = "\(number)"
            if numString.characters.count == 1 {
                numString = "0" + numString
            }
            pickerData.append(numString)
        }
        timerPicker.selectRow(pickerDataSize/2, inComponent: 0, animated: false)
        timerPicker.selectRow(pickerDataSize/2, inComponent: 1, animated: false)
    }
    
    func constrain() {
        addSubview(timerPicker)
        timerPicker.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
    
}

extension TimerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // TODO: Lots of memory wasted here
        return pickerDataSize
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let rowMod = row % 60
        let title = "\(pickerData[rowMod])"
        return title
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
