//
//  PointAndShootVC.swift
//  NeuroRunner
//
//  Created by Robert Deans on 8/7/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

class PointAndShootVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pointShootView = PointShootView()
        
        view.addSubview(pointShootView)
        pointShootView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(navBarHeight + statusBarHeight)
            $0.bottom.equalToSuperview().offset(-(tabBarHeight))
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
