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
    var breathingExerciseVC: BreathingExerciseVC!
    let balanceButton = UIButton()
    var balanceExerciseVC: BalanceExerciseVC!
    let pointShootButton = UIButton()
    var pointShootVC: PointAndShootVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)

        configure()
        constrain()
        
        
    }
    
    func configure() {
        navigationItem.title = "Exercise Menu"
        
        airGameButton.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        airGameButton.setTitle("Air Hunger Games", for: .normal)
        airGameButton.addTarget(self, action: #selector(presentAirExerciseController), for: .touchUpInside)
        
        balanceButton.backgroundColor = UIColor.purple.withAlphaComponent(0.4)
        balanceButton.setTitle("Balance Games", for: .normal)
        balanceButton.addTarget(self, action: #selector(presentBalanceExerciseController), for: .touchUpInside)
        
        pointShootButton.backgroundColor = UIColor.green.withAlphaComponent(0.4)
        pointShootButton.setTitle("Point and Shoot", for: .normal)
        pointShootButton.addTarget(self, action: #selector(presentPointAndShootController), for: .touchUpInside)
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
        
        view.addSubview(pointShootButton)
        pointShootButton.snp.makeConstraints {
            $0.centerX.equalTo(airGameButton.snp.centerX)
            $0.top.equalTo(airGameButton.snp.bottom).offset(15)
            $0.width.equalTo(airGameButton.snp.width)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentAirExerciseController() {
        breathingExerciseVC = BreathingExerciseVC()
        navigationController?.pushViewController(breathingExerciseVC, animated: true)
    }
    
    func presentBalanceExerciseController() {
        balanceExerciseVC = BalanceExerciseVC()
        navigationController?.pushViewController(balanceExerciseVC, animated: true)
    }
    
    func presentPointAndShootController() {
        pointShootVC = PointAndShootVC()
        navigationController?.pushViewController(pointShootVC, animated: true)
    }
    
    
}
