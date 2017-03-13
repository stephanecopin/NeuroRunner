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
        configure()
        getDataAndCreateBarChart()
        constrain()
    }
    
    func configure() {
        user = store.user
        userGames = user.airHungerGames
        
        axisFormatDelegate = self
        
        combinedChartView.noDataText = "No data to present yet"

        combinedChartView.xAxis.granularity = 1.0
        
        backgroundColor = UIColor.cyan
        
    }
    
    func constrain() {

        addSubview(combinedChartView)
        combinedChartView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(combinedChartView.snp.width)
        }
        
    }
    
    func setLineData() {
        
    }
    
    func setBarData() {
        
    }
    
    func getDataAndCreateBarChart() {
        for game in userGames {
            var counter = 1
            let gameLength = ((game.timeSpentBreathing + game.timeSpentHungering) / 60)
            gameLengths.append(gameLength)
            
            let percent = ((game.timeSpentHungering) / (game.timeSpentBreathing + game.timeSpentHungering))
            
            gamePercents.append(percent)
            
            gameDates.append(game.dateOfExercise)
            

            counter += 1
            
        }
        print("gameDates = \(gameDates)")
        print("percentHungering = \(gameLengths)")
        
        createBarChart(dateOfGame: gameDates, lengthOfGame: gameLengths, percentOfGame: gamePercents)
    }
    
    func createBarChart(dateOfGame: [Date], lengthOfGame: [Double], percentOfGame: [Double]) {
        
        
        
        var barDataEntries = [ChartDataEntry]()
        var lineDataEntries = [ChartDataEntry]()
        
        for i in 0..<dateOfGame.count {
            
            let barDataEntry = BarChartDataEntry(x: Double(i+1), y: lengthOfGame[i])
            barDataEntries.append(barDataEntry)

            let lineDataEntry = ChartDataEntry(x: Double(i+1), y: percentOfGame[i])
                
            lineDataEntries.append(lineDataEntry)
            
        }
        
        let lineChartDataSet = LineChartDataSet(values: lineDataEntries, label: "Percent of Time Hungering")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        
        
        let barChartDataSet = BarChartDataSet(values: barDataEntries, label: "Length of Games")
        let barChartData = BarChartData(dataSet: barChartDataSet)
        
        
        
        let xAxis = combinedChartView.xAxis
        xAxis.valueFormatter = axisFormatDelegate
        xAxis.labelRotationAngle = -45
        
        let combinedChartData = CombinedChartData()
        
        combinedChartData.barData = barChartData
        combinedChartData.lineData = lineChartData
        
        combinedChartView.data = combinedChartData
        
    }
    
}

extension ProfileView: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
    
}









