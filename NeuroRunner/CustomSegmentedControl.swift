//
//  CustomSegmentedControl.swift
//  NeuroRunner
//
//  Created by Robert Deans on 5/8/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit

class CustomSegmentedControl: UIControl {
    
    private var labels = [UILabel]()
    
    var thumbView = UIView()
    
    var items = [String]() {
        didSet {
            setupLabels()
        }
    }
    
    var selectedSegmentIndex: Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    convenience init(items: [String]) {
        self.init()
        self.items = items
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func configure() {
        // TODO: FIX CORNER RADIUS
        layoutIfNeeded()
        
        layer.cornerRadius = self.frame.height / 2
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 2
        backgroundColor = UIColor.clear
        
        setupLabels()
        
        insertSubview(thumbView, at: 0)
    }
    
    func setupLabels() {
        layoutIfNeeded()
        
        for label in labels {
            label.removeFromSuperview()
        }
        labels.removeAll(keepingCapacity: true)
        
        for item in items {
            let label = UILabel(frame: .zero)
            label.text = item
            label.textAlignment = .center
            label.textColor = UIColor.white
            self.addSubview(label)
            labels.append(label)
        }
    }
    
    func displayNewSelectedIndex() {
        let label = labels[selectedSegmentIndex]
        self.thumbView.frame = label.frame
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelHeight = self.bounds.height
        let labelWidth = self.bounds.width / CGFloat(labels.count)
        
        for (index, label) in labels.enumerated() {
            let xPostition = CGFloat(index) * labelWidth
            
            label.frame = CGRect(x: xPostition, y: 0, width: labelWidth, height: labelHeight)
            
        }
        
        if labels.count > 0 && labels.count > selectedSegmentIndex {
            let labelFrame = labels[selectedSegmentIndex].frame
            
            thumbView.frame = CGRect(x: labelFrame.minX, y: labelFrame.minY, width: labelFrame.width, height: labelFrame.height)
            thumbView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            thumbView.layer.cornerRadius = thumbView.frame.height / 2
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        var calculatedIndex: Int?
        
        for (index, item) in labels.enumerated() {
            if item.frame.contains(location) {
                calculatedIndex = index
            }
        }
        
        if calculatedIndex != nil {
            selectedSegmentIndex = calculatedIndex!
            sendActions(for: .valueChanged)
        }
        
        return false
    }
    
}
