//
//  GameSummaryViewController.swift
//  NeuroRunner
//
//  Created by Robert Deans on 3/10/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

class AirGameSummaryViewController: UIViewController {

    let store = DataStore.shared
    var user: User!
    var gameSummaryView: GameSummaryView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        user = store.user

        if user.airHungerGames.count > 0, let lastGame = user.airHungerGames.last {

            gameSummaryView = GameSummaryView(with: lastGame)
            
            view.addSubview(gameSummaryView)
            gameSummaryView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
            gameSummaryView.dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
            
        }

    }
    
    func dismissView() {
        print("dismiss View tapped")
        /*
        if let parent = parent as? HomeViewController {
            // set properties of parent as they were
        }
        */
        
        dismiss(animated: true, completion: nil)
        
        /* Old transition
        willMove(toParentViewController: nil)
        view.removeFromSuperview()
        removeFromParentViewController()
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
