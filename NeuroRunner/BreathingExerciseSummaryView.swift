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

class BreathingExerciseSummaryView: UIView {
    
    var lastGame: BreathingExercise!
    var timeBreathing = 0.0
    var timeHungering = 0.0
    
    var totalTime: Double {
        return timeBreathing + timeHungering
    }
    
    var blurView: UIVisualEffectView!
    let summaryView = UIView()
    var dismissButton = UIButton()
    let titleLabel = UILabel()
    
    let pieChartView = PieChartView()
    
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(with game: BreathingExercise) {
        self.init(frame: CGRect.zero)
        
        lastGame = game
        
        configure()
        createChart()
        constrain()
    }
    
    func configure() {
        
        
        timeBreathing = lastGame.timeSpentBreathing
        timeHungering = lastGame.timeSpentHungering
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        
        summaryView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        summaryView.layer.cornerRadius = 5
        summaryView.clipsToBounds = true
        
        titleLabel.text = "Last Game\n\(lastGame.dateOfExercise)"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "MarkerFelt-Thin", size: 38)
        titleLabel.textColor = UIColor.white
        
        dismissButton.setTitle("OK", for: .normal)
        dismissButton.backgroundColor = UIColor.babyBlue
        dismissButton.setTitleColor(UIColor.white, for: .normal)
        dismissButton.titleLabel?.font = UIFont(name: "MarkerFelt-Thin", size: 28)

    }

    func constrain() {
        
        addSubview(blurView)
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
 
        
        addSubview(summaryView)
        summaryView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.edges.equalTo(UIEdgeInsetsMake(65, 25, 150, 25))
//            $0.width.equalToSuperview().multipliedBy(0.8)
//            $0.height.equalToSuperview().multipliedBy(0.6)

        }
        
        summaryView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
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
            $0.height.equalToSuperview().dividedBy(8)
        }
        
    }
    
    
    func createChart() {
//        let numberFormatter = NumberFormatter()
//        numberFormatter.minimumFractionDigits = 2
//        numberFormatter.maximumFractionDigits = 2
//        
//        let totalTimeString = numberFormatter.string(from: NSNumber(floatLiteral: totalTime))
//        let breathingTimeString = numberFormatter.string(from: NSNumber(floatLiteral: timeBreathing))
//        let hungerTimeString = numberFormatter.string(from: NSNumber(floatLiteral: timeHungering))
//        
//        
        let sectionNames = ["Time Breathing", "Time Hungering"]
        let sectionTimes = [timeBreathing, timeHungering]
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<sectionNames.count {
            let dataEntry = PieChartDataEntry(value: sectionTimes[i], label: sectionNames[i])
            dataEntries.append(dataEntry)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        
        // Pie Chart Customization
        let darkColors = [UIColor.darkColor1, UIColor.darkColor2, UIColor.darkColor3]
        let lightColors = [UIColor.lightColor1, UIColor.lightColor2, UIColor.lightColor3]
        var colors: [UIColor] = []
        colors.append(lightColors[Int(arc4random_uniform(3))])
        colors.append(darkColors[Int(arc4random_uniform(3))])
        pieChartDataSet.colors = colors
        
        let description = Description()
        description.text = ""
        pieChartView.chartDescription = description

    }
}

//extension GameSummaryView: IValueFormatter {
//    
//    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
//
//        let numberFormatter = NumberFormatter()
//        numberFormatter.minimumFractionDigits = 2
//        numberFormatter.maximumFractionDigits = 2
//        
//        let totalTimeString = numberFormatter.string(from: NSNumber(floatLiteral: totalTime))
//        let breathingTimeString = numberFormatter.string(from: NSNumber(floatLiteral: timeBreathing))
//        let hungerTimeString = numberFormatter.string(from: NSNumber(floatLiteral: timeHungering))
//        
//        return breathingTimeString!
//        
//    }
//    
//}









