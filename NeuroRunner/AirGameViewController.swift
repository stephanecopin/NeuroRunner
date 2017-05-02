//
//  ViewController.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/22/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import RealmSwift


class AirGameViewController: UIViewController {

    let store = DataStore.shared
    let airGameView = AirGameView()
    var airGameSummaryViewController: AirGameSummaryViewController!
    
    var isMicrophoneEnabled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        
        let realmUser = store.realm.objects(User.self)
        
        print("REALM HAS \(realmUser.count) USER(S)!")
        print("LOCAL USER HAS \(store.user.airHungerGames.count) games")
        
        
    }

    func initialSetup() {
        // Customize Navigation Bar
        navigationItem.title = "Air Hunger Games"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Mic Disabled", style: .plain, target: self, action: #selector(toggleMic))
        
        // Set Delegates
        airGameView.airGameViewModel.presentGameSummaryDelegate = self
        
        // Add View
        view.addSubview(airGameView)
        airGameView.snp.makeConstraints{
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-49)
        }
    }
    
    func toggleMic() {
        airGameView.airGameViewModel.inputTimer.microphone.isMicrophoneEnabled = !airGameView.airGameViewModel.inputTimer.microphone.isMicrophoneEnabled
        
        
        if airGameView.airGameViewModel.inputTimer.microphone.isMicrophoneEnabled {
            navigationItem.rightBarButtonItem?.title = "Mic Enabled"
            airGameView.airGameViewModel.inputMethod = .Microphone
        } else {
            navigationItem.rightBarButtonItem?.title = "Mic Disabled"
            airGameView.airGameViewModel.inputMethod = .manual
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension AirGameViewController: PresentGameSummaryDelegate {
    
    func presentGameSummary() {
        airGameSummaryViewController = AirGameSummaryViewController()

        airGameSummaryViewController.providesPresentationContextTransitionStyle = true
        airGameSummaryViewController.definesPresentationContext = true
        airGameSummaryViewController.modalPresentationStyle = .overFullScreen
        self.present(airGameSummaryViewController, animated: true, completion: nil)
        
/*      Old transition
        addChildViewController(gameSummaryViewController)
        view.addSubview(gameSummaryViewController.view)
        gameSummaryViewController.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        gameSummaryViewController.didMove(toParentViewController: nil)
        view.layoutIfNeeded()

*/
        
    }
}
