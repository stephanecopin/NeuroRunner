//
//  GameSummaryView.swift
//  NeuroRunner
//
//  Created by Robert Deans on 3/10/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import SnapKit
import Charts
import RealmSwift

class GameSummaryView: UIView {
    
    var lastGame: AirHungerGame!
    
    var blurView: UIVisualEffectView!
    let summaryView = UIView()
    let dismissButton = UIButton()
    let breathingLabel = UILabel()
    
    let pieChartView = PieChartView()
    
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(with game: AirHungerGame) {
        self.init(frame: CGRect.zero)
        
        lastGame = game

        breathingLabel.text = "\(lastGame.timeSpentBreathing) seconds breathing"
        
        configure()
        createChart()
        constrain()
    }
    
    func configure() {
        
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
        blurView.alpha = 0.4
        
        summaryView.backgroundColor = UIColor.purple
        
        breathingLabel.font = UIFont(name: "MarkerFelt-Thin", size: 28)
        
        dismissButton.setTitle("OK", for: .normal)
        dismissButton.backgroundColor = UIColor.blue
        dismissButton.setTitleColor(UIColor.white, for: .normal)
        dismissButton.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 28)
        
    }

    func constrain() {
        /*
        addSubview(blurView)
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        */
        
        addSubview(summaryView)
        summaryView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.6)

        }
        
        summaryView.addSubview(pieChartView)
        pieChartView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(pieChartView.snp.width)
        }
        
        summaryView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints {
            $0.width.centerX.bottom.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(10)
        }
        
    }
    
    func createChart() {
        
        let timeBreathing = lastGame.timeSpentBreathing
        let timeHungering = lastGame.timeSpentHungering
        var totalTime: Double {
            return timeBreathing + timeHungering
        }
        print("Charts timeBreathing = \(timeBreathing)")
        print("Charts timeHungering = \(timeHungering)")

        let chartSections = ["Time Breathing", "Time Hungering"]
        let sectionTimes = [timeBreathing, timeHungering]
        
        setCharts(dataPoints: chartSections, values: sectionTimes)
        
    }
    
    
    func setCharts(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "Units Sold")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        
        
    }
}










