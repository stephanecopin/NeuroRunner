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
        view.willRemoveSubview(profileView)

        profileView = ProfileView()
        
        view.addSubview(profileView)
        profileView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    
    }

}
