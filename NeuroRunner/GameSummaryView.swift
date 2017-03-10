//
//  GameSummaryView.swift
//  NeuroRunner
//
//  Created by Robert Deans on 3/10/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import SnapKit

class GameSummaryView: UIView {
    
    var lastGame: AirHungerGame!
    
    var blurView: UIVisualEffectView!
    let summaryView = UIView()
    let dismissButton = UIButton()
    let breathingLabel = UILabel()
    
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(with game: AirHungerGame) {
        self.init(frame: CGRect.zero)
        
        lastGame = game

        breathingLabel.text = "\(lastGame.timeSpentBreathing) seconds breathing"
        
        configure()
        constrain()
    }
    
    func configure() {
        
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
        blurView.alpha = 0.4
        
        summaryView.backgroundColor = UIColor.purple
        
        breathingLabel.font = UIFont(name: "MarkerFelt-Thin", size: 28)
        
        dismissButton.setTitle("OK", for: .normal)
        dismissButton.backgroundColor = UIColor.blue
        dismissButton.setTitleColor(UIColor.white, for: .normal)
        dismissButton.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 28)
        
    }

    func constrain() {
        /*
        addSubview(blurView)
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        */
        
        addSubview(summaryView)
        summaryView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.6)

        }
        
        summaryView.addSubview(breathingLabel)
        breathingLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        summaryView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints {
            $0.width.centerX.bottom.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(10)
        }
        
    }
}
