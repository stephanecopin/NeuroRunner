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
    
    var chartUIView: UIView!
    
    
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
        chartUIView = UIView()
        chartUIView.layer.cornerRadius = 25
        chartUIView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        
        if user.airHungerGames.count > 0 {
            createChart()
            configureChart()
            constrain()
        }
    }
    
    
    
    func constrain() {
        
        addSubview(chartUIView)
        chartUIView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(chartUIView.snp.width)
        }
        
        chartUIView.addSubview(combinedChartView)
        combinedChartView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
    }
    
    func configureChart() {
        lineChartDataSet.mode = .cubicBezier
        lineChartDataSet.lineCapType = .butt
        lineChartDataSet.setCircleColor(UIColor.blue)
        lineChartDataSet.setColor(UIColor.green)
        
        barChartDataSet.setColor(UIColor.breathingButtonOff)
        
        axisFormatDelegate = self
        let xAxis = combinedChartView.xAxis
        xAxis.valueFormatter = axisFormatDelegate
        xAxis.labelRotationAngle = -45
        xAxis.spaceMin = 0.5
        xAxis.spaceMax = 0.5
        
        let yFormatter = NumberFormatter()
        yFormatter.numberStyle = NumberFormatter.Style.none
        combinedChartView.leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: yFormatter)
        
        combinedChartView.noDataText = "No data to present yet"
        
        let description = Description()
        description.text = ""
        combinedChartView.chartDescription = description
        
        combinedChartView.xAxis.granularity = 1.0
        
        
        
        
    }
    
    func createChart() {
        
        for game in userGames {
            
            let gameLength = ((game.timeSpentBreathing + game.timeSpentHungering) / 60)
            gameLengths.append(gameLength)
            
            // percent = total gameLength * percentage spent breathing
            let percent = ( gameLength * ((game.timeSpentHungering) / (game.timeSpentBreathing + game.timeSpentHungering)))
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









