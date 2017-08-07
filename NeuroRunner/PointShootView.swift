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
    
    let startingPointButton = UIButton()
    let beginExerciseButton = UIButton()

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
        startingPointButton.backgroundColor = UIColor.cyan
        startingPointButton.setTitle("Starting Point", for: .normal)
        startingPointButton.addTarget(self, action: #selector(recordStartHeading), for: .touchUpInside)
        
        beginExerciseButton.backgroundColor = UIColor.green
        beginExerciseButton.setTitle("Begin Exercise", for: .normal)
        beginExerciseButton.addTarget(self, action: #selector(beginExercise), for: .touchUpInside)

    }
    
    func constrain() {
    
        addSubview(startingPointButton)
        startingPointButton.snp.makeConstraints {
            $0.bottom.width.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(10)
        }
        
        addSubview(beginExerciseButton)
        beginExerciseButton.snp.makeConstraints {
            $0.width.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(10)
            $0.bottom.equalTo(startingPointButton.snp.top).offset(-20)
        }
        
    }
    
    func recordStartHeading() {
        exercise.recordStartHeading()
    }
    
    func beginExercise() {
        
    }
    
}
