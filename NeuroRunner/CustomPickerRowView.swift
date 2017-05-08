//
//  CustomPickerRowView.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/21/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import Foundation
import UIKit

class CustomPickerRowView: UIView {
    
    let dataLabel = UILabel()
    
    init(frame: CGRect, rowData: String) {
        super.init(frame: frame)
        dataLabel.text = rowData
        dataLabel.textColor = UIColor.white
        dataLabel.font = UIFont(name: "AvenirNext-Regular", size: 40)

        addSubview(dataLabel)
        dataLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
