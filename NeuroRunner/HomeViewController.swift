//
//  ViewController.swift
//  NeuroRunner
//
//  Created by Robert Deans on 2/22/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import AudioKit


class HomeViewController: UIViewController {

    var airGameView: AirGameView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        airGameView = AirGameView()
        view.addSubview(airGameView)
        airGameView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        AudioKit.output = airGameView.microphoneAnalysis.silence
        AudioKit.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

