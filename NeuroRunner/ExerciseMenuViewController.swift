//
//  ExerciseMenuViewController.swift
//  NeuroRunner
//
//  Created by Robert Deans on 4/19/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

class ExerciseMenuViewController: UIViewController {

    let airGameButton = UIButton()
    var airGameViewController: AirGameViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        airGameButton.backgroundColor = UIColor.blue.withAlphaComponent(0.4)
        airGameButton.setTitle("Air Hunger Games", for: .normal)
        airGameButton.addTarget(self, action: #selector(presentAirExerciseController), for: .touchUpInside)
        view.addSubview(airGameButton)
        airGameButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentAirExerciseController() {
        airGameViewController = AirGameViewController()
        navigationController?.pushViewController(airGameViewController, animated: true)
        /*
 let pictureVC = PictureViewController()
         
 pictureVC.providesPresentationContextTransitionStyle = true
 pictureVC.definesPresentationContext = true
 pictureVC.modalPresentationStyle = .overFullScreen
 self.present(pictureVC, animated: true, completion: nil)
 */
    }

 

}
