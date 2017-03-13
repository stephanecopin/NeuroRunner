//
//  ProfileView.swift
//  NeuroRunner
//
//  Created by Robert Deans on 3/1/17.
//  Copyright © 2017 Robert Deans. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift
import Charts

class ProfileView: UIView {
    
    let store = DataStore.shared
    
    var user: User!
    var userGames = List<AirHungerGame>()
    var gameDates = [Date]()
    var gameLengths = [Double]()
    var gamePercents = [Double]()
    
    let combinedChartView = CombinedChartView()
    var lineChartDataSet: LineChartDataSet!
    var barChartDataSet: BarChartDataSet!
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    
    // MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        user = store.user
        userGames = user.airHungerGames
        backgroundColor = UIColor.cyan

        createChart()
        configureChart()
        constrain()
    }
    
    
    func constrain() {

        addSubview(combinedChartView)
        combinedChartView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(combinedChartView.snp.width)
        }
        
    }

    func configureChart() {
        lineChartDataSet.mode = .cubicBezier
        lineChartDataSet.lineCapType = .butt
        
        axisFormatDelegate = self
        let xAxis = combinedChartView.xAxis
        xAxis.valueFormatter = axisFormatDelegate
        xAxis.labelRotationAngle = -45
        xAxis.spaceMin = 0.5
        xAxis.spaceMax = 0.5
        
        combinedChartView.noDataText = "No data to present yet"
        combinedChartView.xAxis.granularity = 1.0
        
        
        
    }
    
    func createChart() {

        for game in userGames {
            
            let gameLength = ((game.timeSpentBreathing + game.timeSpentHungering) / 60)
            gameLengths.append(gameLength)
            
            let percent = ((game.timeSpentHungering) / (game.timeSpentBreathing + game.timeSpentHungering))
            gamePercents.append(percent)
            
            gameDates.append(game.dateOfExercise)
            
        }
        
        var barDataEntries = [ChartDataEntry]()
        var lineDataEntries = [ChartDataEntry]()
        
        for i in 0..<user.airHungerGames.count {
            
            let barDataEntry = BarChartDataEntry(x: Double(i+1), y: gameLengths[i])
            barDataEntries.append(barDataEntry)

            let lineDataEntry = ChartDataEntry(x: Double(i+1), y: gamePercents[i])
            lineDataEntries.append(lineDataEntry)
            
        }
        
        lineChartDataSet = LineChartDataSet(values: lineDataEntries, label: "Percent of Time Hungering")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        
        
        barChartDataSet = BarChartDataSet(values: barDataEntries, label: "Length of Games")
        let barChartData = BarChartData(dataSet: barChartDataSet)
        
        let combinedChartData = CombinedChartData()
        
        combinedChartData.barData = barChartData
        combinedChartData.lineData = lineChartData
        
        combinedChartView.data = combinedChartData
        
    }
    
}

// Helps to format the X-Axis labels
extension ProfileView: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
    
}









