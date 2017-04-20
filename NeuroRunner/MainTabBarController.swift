//
//  MainTabBarController.swift
//  NeuroRunner
//
//  Created by Robert Deans on 3/1/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    lazy var exerciseNC = UINavigationController(rootViewController: ExerciseMenuViewController())
    lazy var infoNC = UINavigationController(rootViewController: InfoViewController())
    lazy var profileNC = UINavigationController(rootViewController: ProfileViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exerciseNC.tabBarItem = UITabBarItem(title: "Exercises", image: #imageLiteral(resourceName: "Home Tab Bar"), tag: 0)
        infoNC.tabBarItem = UITabBarItem(title: "Info", image: nil, tag: 1)
        profileNC.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "Profile Tab Bar"), tag: 2)
        
        viewControllers = [exerciseNC, infoNC, profileNC]

//        homeNC.navigationBar.isTranslucent = false
//        homeNC.navigationBar.barTintColor = UIColor.blue
//        homeNC.navigationBar.tintColor = UIColor.white
//        homeNC.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
//        profileNC.navigationBar.isTranslucent = false
//        profileNC.navigationBar.barTintColor = UIColor.blue
//        profileNC.navigationBar.tintColor = UIColor.white
//        profileNC.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
