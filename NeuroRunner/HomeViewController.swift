//
//  ViewController.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/22/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import RealmSwift


class HomeViewController: UIViewController {

    let airGameView = AirGameView()
    let airGameViewModel = AirGameViewModel()
    let microphoneViewModel = MicrophoneViewModel()
    
    let store = DataStore.shared
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        
        
    }

    func initialSetup() {
        // Connect to singleton
        user = store.user
        
        // Customize Navigation Bar
        navigationItem.title = "Home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Mic Enabled", style: .plain, target: self, action: #selector(toggleMic))
        
        // Set Delegates
        airGameView.microphoneDelegate = microphoneViewModel
        airGameView.takingBreathDelegate = airGameViewModel
        microphoneViewModel.takingBreathDelegate = airGameViewModel
        microphoneViewModel.breathingViewUpdateDelegate = airGameView
        
        
        // Add View
        view.addSubview(airGameView)
        airGameView.snp.makeConstraints{
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-49)
        }
    }
    
    func toggleMic() {
        microphoneViewModel.isMicrophoneEnabled = !microphoneViewModel.isMicrophoneEnabled
        
        if microphoneViewModel.isMicrophoneEnabled {
            navigationItem.rightBarButtonItem?.title = "Mic Enabled"
        } else {
            navigationItem.rightBarButtonItem?.title = "Mic Disabled"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

protocol PresentGameSummary {
    
    func presentGameSummary()
    
}

extension HomeViewController: PresentGameSummary {
    
    func presentGameSummary() {

        if user.airHungerGames.count > 0 {
            let lastGame = user.airHungerGames[0]
            let gameSummary = GameSummaryView(with: lastGame)
            
            view.addSubview(gameSummary)
            gameSummary.snp.makeConstraints {
                $0.centerX.centerY.equalToSuperview()
                $0.width.height.equalToSuperview().multipliedBy(0.8)
            }
            
        }
    }
}

