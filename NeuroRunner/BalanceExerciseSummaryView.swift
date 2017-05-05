//
//  BalanceExerciseSummaryView.swift
//  NeuroRunner
//
//  Created by Robert Deans on 5/5/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import SnapKit
import Charts
import RealmSwift

class BalanceExerciseSummaryView: UIView {
    
    var lastGame: BalanceExercise!
    
    var blurView: UIVisualEffectView!
    let summaryView = UIView()
    var dismissButton = UIButton()
    let titleLabel = UILabel()
    
    let lineChartView = LineChartView()
    var lineChartDataSet: LineChartDataSet!

    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(with exercise: BalanceExercise) {
        self.init(frame: CGRect.zero)
        
        lastGame = exercise
        
        configure()
        createChart()
        constrain()
    }
    
    func configure() {
        
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        
        
        
        summaryView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        summaryView.layer.cornerRadius = 25
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
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview().multipliedBy(0.6)
            
        }
        
        summaryView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
        }
        
        summaryView.addSubview(lineChartView)
        lineChartView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(lineChartView.snp.width)
        }
        
        summaryView.addSubview(dismissButton)
        dismissButton.snp.makeConstraints {
            $0.width.centerX.bottom.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(8)
        }
        
    }
    
    
    func createChart() {
        
        var lineDataEntries = [ChartDataEntry]()
        
        if let gameMagnitudes = lastGame.magnitudeTimes {
            for (index, mag) in gameMagnitudes.magnitudes.enumerated() {
                let lineDataEntry = ChartDataEntry(x: gameMagnitudes.timeIntervals[index].value, y: mag.value)
                lineDataEntries.append(lineDataEntry)
            }
        }
        
        lineChartDataSet = LineChartDataSet(values: lineDataEntries, label: "Some Label Goes Here")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)

        lineChartView.data = lineChartData
        
    }
}
