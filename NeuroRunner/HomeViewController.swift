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
    var airGameViewModel: AirGameViewModel!
    
    let store = DataStore.shared
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = store.user
        
        navigationItem.title = "Home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Mic Enabled", style: .plain, target: self, action: #selector(toggleMic))

        airGameView = AirGameView()
        airGameViewModel = AirGameViewModel()
        microphoneViewModel = MicrophoneViewModel()

        
        airGameView.microphoneDelegate = microphoneViewModel
        airGameView.takingBreathDelegate = airGameViewModel
        microphoneViewModel.takingBreathDelegate = airGameViewModel
        microphoneViewModel.breathingViewUpdateDelegate = airGameView
        
        view.addSubview(airGameView)
        airGameView.snp.makeConstraints{
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-49)
        }
        
        airGameViewModel = AirGameViewModel()
        
        /*
        let newUser = User()
        let newGame = AirHungerGame()
        
        newUser.name = "Me"
        newUser.airHungerGames.append(newGame)
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(newUser)
        }
        */
        
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

