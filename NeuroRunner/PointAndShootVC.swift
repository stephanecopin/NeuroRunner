//
//  PointAndShootVC.swift
//  NeuroRunner
//
//  Created by Robert Deans on 8/7/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

class PointAndShootVC: UIViewController {

    let exercise = PointAndShoot()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pointShootView = PointShootView()
        
        view.addSubview(pointShootView)
        pointShootView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        $0.bottom.equalToSuperview().offset(-49)
        }

        pointShootView.recordStartButton.addTarget(self, action: #selector(recordStartHeading), for: .touchUpInside)

        
    }

    func recordStartHeading() {
        exercise.recordStartHeading()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
