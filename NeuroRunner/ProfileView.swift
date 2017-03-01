//
//  ProfileView.swift
//  NeuroRunner
//
//  Created by Robert Deans on 3/1/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import SnapKit

class ProfileView: UIView {
    

    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        configure()
        constrain()
    }
    
    func configure() {
        
    }
    
    func constrain() {

    }
}
