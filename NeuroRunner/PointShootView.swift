//
//  PointShootView.swift
//  NeuroRunner
//
//  Created by Robert Deans on 8/7/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import SnapKit

class PointShootView: UIView {
    
    let recordStartButton = UIButton()

    let exercise = PointAndShoot()

    
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
        recordStartButton.backgroundColor = UIColor.cyan
        recordStartButton.setTitle("Starting Point", for: .normal)
        recordStartButton.addTarget(self, action: #selector(recordStartHeading), for: .touchUpInside)

    }
    
    func constrain() {
    
        addSubview(recordStartButton)
        recordStartButton.snp.makeConstraints {
            $0.bottom.width.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(10)
        }
        
    }
    
    func recordStartHeading() {
        exercise.recordStartHeading()
    }
    
}
