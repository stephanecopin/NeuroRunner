//
//  ViewController.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/22/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {

    let user = User()

    var airGameView: AirGameView!
    var microphoneViewModel: MicrophoneViewModel!
    var breathingViewModel: BreathingViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        airGameView = AirGameView()
        breathingViewModel = BreathingViewModel()
        microphoneViewModel = MicrophoneViewModel()
        microphoneViewModel.configure()
        microphoneViewModel.setUpRecorder()
        
        airGameView.microphoneDelegate = microphoneViewModel
        airGameView.takingBreathDelegate = breathingViewModel
        
        view.addSubview(airGameView)
        airGameView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        breathingViewModel = BreathingViewModel()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

