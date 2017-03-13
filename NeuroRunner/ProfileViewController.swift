//
//  ProfileViewController.swift
//  NeuroRunner
//
//  Created by Robert Deans on 3/1/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    let store = DataStore.shared
    var user: User!
    
    var profileView: ProfileView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = store.user
        
        navigationItem.title = "Profile"

        let color1 = UIColor(red: 34/255.0, green: 91/255.0, blue: 102/255.0, alpha: 1.0)
        let color2 = UIColor(red: 141/255.0, green: 191/255.9, blue: 103/255.0, alpha: 1.0)
        
        let backgroundGradient = CALayer.makeGradient(firstColor: color1, secondColor: color2)
        
        backgroundGradient.frame = view.frame
        self.view.layer.insertSublayer(backgroundGradient, at: 0)
        
        profileView = ProfileView()

        view.addSubview(profileView)
        profileView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppearing")

        profileView.removeFromSuperview()
        profileView = ProfileView()
        
        view.addSubview(profileView)
        profileView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    
    }

}
