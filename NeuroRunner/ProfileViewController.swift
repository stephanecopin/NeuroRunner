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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = store.user
        
        navigationItem.title = "Profile"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
