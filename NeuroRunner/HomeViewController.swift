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
    let microphoneViewModel = MicrophoneViewModel()
    
    var gameSummaryViewController: GameSummaryViewController!
    
    let store = DataStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        
        let realmUser = store.realm.objects(User.self)
        
        print("REALM HAS \(realmUser.count) USER(S)!")
        print("LOCAL USER HAS \(store.user.airHungerGames.count) games")
        
        
    }

    func initialSetup() {
        // Customize Navigation Bar
        navigationItem.title = "Home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Enable Mic", style: .plain, target: self, action: #selector(toggleMic))
        
        // Set Delegates
        airGameView.microphoneDelegate = microphoneViewModel
        airGameView.airGameViewModel.presentGameSummaryDelegate = self
        
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
            navigationItem.rightBarButtonItem?.title = "Disable Mic"
        } else {
            navigationItem.rightBarButtonItem?.title = "Enable Mic"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

protocol PresentGameSummaryDelegate {
    
    func presentGameSummary()
    
}

extension HomeViewController: PresentGameSummaryDelegate {
    
    func presentGameSummary() {
        print("presentGameSummary delegate called")

        gameSummaryViewController = GameSummaryViewController()
        
        addChildViewController(gameSummaryViewController)
        
        view.addSubview(gameSummaryViewController.view)
        gameSummaryViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        gameSummaryViewController.didMove(toParentViewController: nil)
        
        view.layoutIfNeeded()
        
    }
}

