//
//  ViewController.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/22/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {

    var airGameView: AirGameView!
    var microphoneViewModel: MicrophoneViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        airGameView = AirGameView()
        microphoneViewModel = MicrophoneViewModel()
        microphoneViewModel.configure()
        microphoneViewModel.setUpRecorder()
        
        airGameView.microphoneDelegate = microphoneViewModel
        
        view.addSubview(airGameView)
        airGameView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

