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

    var airGameView: AirGameView!
    var microphoneViewModel: MicrophoneViewModel!
    var breathingViewModel: BreathingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"

        airGameView = AirGameView()
        breathingViewModel = BreathingViewModel()
        microphoneViewModel = MicrophoneViewModel()
        microphoneViewModel.configure()
        microphoneViewModel.setUpRecorder()
        
        airGameView.microphoneDelegate = microphoneViewModel
        airGameView.takingBreathDelegate = breathingViewModel
        microphoneViewModel.takingBreathDelegate = breathingViewModel
        microphoneViewModel.breathingViewUpdateDelegate = airGameView
        
        view.addSubview(airGameView)
        airGameView.snp.makeConstraints{
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-49)
        }
        
        breathingViewModel = BreathingViewModel()
        
        
        let newUser = User()
        let newGame = AirHungerGame()
        
        newUser.name = "Me"
        newUser.airHungerGames.append(newGame)
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(newUser)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

