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
    
    var items = ["Item 1", "Item 2"] {
        didSet {
            setupLabels()
        }
    }
    
    var selectedIndex: Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
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
        layer.cornerRadius = self.frame.height / 2
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 2
        backgroundColor = UIColor.clear
        
        setupLabels()
        
        insertSubview(thumbView, at: 0)
    }
    
    func setupLabels() {
        for label in labels {
            label.removeFromSuperview()
        }
        labels.removeAll(keepingCapacity: true)
        
        for index in 1...items.count {
            let label = UILabel(frame: .zero)
            label.text = items[index-1]
            label.textAlignment = .center
            label.textColor = UIColor.white
            self.addSubview(label)
            labels.append(label)
        }
    }
    
    func displayNewSelectedIndex() {
        let label = labels[selectedIndex]
        self.thumbView.frame = label.frame
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectFrame = self.bounds
        let newWidth = selectFrame.width / CGFloat(items.count)
        selectFrame.size.width = newWidth
        
        thumbView.frame = selectFrame
        thumbView.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        thumbView.layer.cornerRadius = thumbView.frame.height / 2
        
        let labelHeight = self.bounds.height
        let labelWidth = self.bounds.width / CGFloat(labels.count)
        
        for index in 0...labels.count - 1{
            let label = labels[index]
            
            let xPostition = CGFloat(index) * labelWidth
            label.frame = CGRect(x: xPostition, y: 0, width: labelWidth, height: labelHeight)
            
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
            selectedIndex = calculatedIndex!
            sendActions(for: .valueChanged)
        }
        
        return false
    }
    
}
