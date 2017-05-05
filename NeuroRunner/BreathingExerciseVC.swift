//
//  ViewController.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/22/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import RealmSwift


class BreathingExerciseVC: UIViewController {

    let store = DataStore.shared
    let breathingView = BreathingView()
    var breathingSummaryVC: BreathingSummaryVC!
    
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
        breathingView.airGameViewModel.presentGameSummaryDelegate = self
        
        // Add View
        view.addSubview(breathingView)
        breathingView.snp.makeConstraints{
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-49)
        }
    }
    
    func toggleMic() {
        breathingView.airGameViewModel.inputTimer.microphone.isMicrophoneEnabled = !breathingView.airGameViewModel.inputTimer.microphone.isMicrophoneEnabled
        
        
        if breathingView.airGameViewModel.inputTimer.microphone.isMicrophoneEnabled {
            navigationItem.rightBarButtonItem?.title = "Mic Enabled"
            breathingView.airGameViewModel.inputMethod = .Microphone
        } else {
            navigationItem.rightBarButtonItem?.title = "Mic Disabled"
            breathingView.airGameViewModel.inputMethod = .manual
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension BreathingExerciseVC: PresentGameSummaryDelegate {
    
    func presentGameSummary() {
        breathingSummaryVC = BreathingSummaryVC()

        breathingSummaryVC.providesPresentationContextTransitionStyle = true
        breathingSummaryVC.definesPresentationContext = true
        breathingSummaryVC.modalPresentationStyle = .overFullScreen
        self.present(breathingSummaryVC, animated: true, completion: nil)
        
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

