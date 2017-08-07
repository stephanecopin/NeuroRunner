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
    
    let exercise = PointAndShoot()
    
    let startingPointButton = UIButton()
    let beginExerciseButton = UIButton()
    
    var startingPointLabel: UILabel!
    var currentHeadingLabel: UILabel!
    
    var minLabel: UILabel!
    var maxLabel: UILabel!
    
    
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
        exercise.updateLabelDelegate = self
        
        startingPointLabel = UILabel()
        startingPointLabel.font = UIFont(name: "AvenirNext-Bold", size: 50)
        startingPointLabel.textColor = UIColor.white
        
        currentHeadingLabel = UILabel()
        currentHeadingLabel.font = UIFont(name: "AvenirNext-Regular", size: 75)
        currentHeadingLabel.textColor = UIColor.white
        
        minLabel = UILabel()
        minLabel.font = UIFont(name: "AvenirNext-Regular", size: 25)
        minLabel.textColor = UIColor.white
        
        maxLabel = UILabel()
        maxLabel.font = UIFont(name: "AvenirNext-Regular", size: 25)
        maxLabel.textColor = UIColor.white
        
        startingPointButton.backgroundColor = UIColor.cyan
        startingPointButton.setTitle("Starting Point", for: .normal)
        startingPointButton.addTarget(self, action: #selector(recordStartHeading), for: .touchUpInside)
        
        beginExerciseButton.backgroundColor = UIColor.green
        beginExerciseButton.setTitle("Begin Exercise", for: .normal)
        beginExerciseButton.addTarget(self, action: #selector(beginExercise), for: .touchUpInside)

    }
    
    func constrain() {
    
        addSubview(startingPointLabel)
        startingPointLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(20)
        }
        
        addSubview(currentHeadingLabel)
        currentHeadingLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()

        }
        
        addSubview(startingPointButton)
        startingPointButton.snp.makeConstraints {
            $0.bottom.width.centerX.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(10)
        }
        
        addSubview(minLabel)
        minLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview().multipliedBy(0.75)
        }
        
        addSubview(maxLabel)
        maxLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().multipliedBy(0.75)
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
        
        if let startingPoint = exercise.startHeading?.magneticHeading.roundTo(places: 4) {
            startingPointLabel.text = "\(startingPoint)"
        } else {
            print("error :(")
        }

    }
    
    func beginExercise() {

        if let min = exercise.minHeading?.magneticHeading, let max = exercise.maxHeading?.magneticHeading {
            print("MIN: \(min)\nMax: \(max)")
        }
    }
    
}

extension PointShootView: UpdateLabelDelegate {
    
    func updateLabel(with content: String) {
        currentHeadingLabel.text = "\(content)"
    }
}
