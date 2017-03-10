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

        breathingLabel.text = String(lastGame.timeSpentBreathing)
        
        configure()
        constrain()
    }
    
    func configure() {
        
        breathingLabel.font = UIFont(name: "MarkerFelt-Thin", size: 28)

        
        dismissButton.setTitle("OK", for: .normal)
        dismissButton.backgroundColor = UIColor.green
        dismissButton.setTitleColor(UIColor.white, for: .normal)
        dismissButton.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 28)
        dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        
    }

    func constrain() {
        
        addSubview(breathingLabel)
        breathingLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        addSubview(dismissButton)
        dismissButton.snp.makeConstraints {
            $0.width.bottom.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(10)
        }
        
    }
    
    func dismissView() {
        print("dismiss View tapped")
        
    }
}
