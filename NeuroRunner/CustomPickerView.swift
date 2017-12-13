//
//  TimerVier.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/21/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

class CustomPickerView: UIView {

    
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
        
        timerPicker.dataSource = self
        timerPicker.delegate = self
        timerPicker.autoresizingMask = .flexibleWidth
        
        for number in 0...59 {
            var numString = "\(number)"
            if numString.count == 1 {
                numString = "0" + numString
            }
            pickerData.append(numString)
        }
        timerPicker.selectRow(pickerDataSize/2, inComponent: 0, animated: false)
    }
    
    func constrain() {
        addSubview(timerPicker)
        timerPicker.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
}

extension CustomPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // TODO: Lots of memory wasted here?
        return pickerDataSize
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let rowMod = row % 60
        let title = "\(pickerData[rowMod])"
        return title
    }
    
//     Custom Picker Cell Functions
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.bounds.size.width
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 64.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let rowMod = row % 60
        let rowData = pickerData[rowMod]
        let customView = CustomPickerRowView(frame: .zero, rowData: rowData)
        return customView
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
