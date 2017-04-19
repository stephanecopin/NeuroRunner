//
//  ExerciseMenuViewController.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/19/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

class ExerciseMenuViewController: UIViewController {
    
    let airGameButton = UIButton()
    var airGameViewController: AirGameViewController!
    let balanceButton = UIButton()
    var balanceGameViewController: BalanceGameViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)

        configure()
        constrain()
        
        
    }
    
    func configure() {
        airGameButton.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        airGameButton.setTitle("Air Hunger Games", for: .normal)
        airGameButton.addTarget(self, action: #selector(presentAirExerciseController), for: .touchUpInside)
        
        balanceButton.backgroundColor = UIColor.purple.withAlphaComponent(0.4)
        balanceButton.setTitle("Balance Games", for: .normal)
        balanceButton.addTarget(self, action: #selector(presentBalanceExerciseController), for: .touchUpInside)
    }
    
    func constrain() {
        view.addSubview(airGameButton)
        airGameButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(view.snp.centerX).offset(-5)
        }
        
        view.addSubview(balanceButton)
        balanceButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(view.snp.centerX).offset(5)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentAirExerciseController() {
        airGameViewController = AirGameViewController()
        navigationController?.pushViewController(airGameViewController, animated: true)
    }
    
    func presentBalanceExerciseController() {
        balanceGameViewController = BalanceGameViewController()
        navigationController?.pushViewController(balanceGameViewController, animated: true)
    }
    
    
    
}
