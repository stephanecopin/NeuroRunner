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
    
    let barChartView = BarChartView()
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
        
        barChartView.noDataText = "No data to present yet"

        backgroundColor = UIColor.cyan
        
    }
    
    func constrain() {

        addSubview(barChartView)
        barChartView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(barChartView.snp.width)
        }
        
    }
    
    func setLineData() {
        
    }
    
    func setBarData() {
        
    }
    
    func getDataAndCreateBarChart() {
        var shouldBeDates = [String]()
        for game in userGames {
            var counter = 1
            let gameLength = ((game.timeSpentBreathing + game.timeSpentHungering) / 60)
            gameLengths.append(gameLength)
            
            gameDates.append(game.dateOfExercise)
            
            shouldBeDates.append("\(counter)")
            counter += 1
            
        }
        print("gameDates = \(gameDates)")
        print("percentHungering = \(gameLengths)")
        
        createBarChart(dataPoints: gameDates, values: gameLengths)
    }
    
    func createBarChart(dataPoints: [Date], values: [Double]) {
        
        var dataEntries = [BarChartDataEntry]()
        
        for i in 0..<dataPoints.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i+1), y: values[i])
            
            dataEntries.append(dataEntry)
            
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Length of Games")
        let chartData = BarChartData(dataSet: chartDataSet)
        
        barChartView.data = chartData
        
        let xAxis = barChartView.xAxis
        xAxis.valueFormatter = axisFormatDelegate
    }
    
}

extension ProfileView: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a, MMM d"
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
    
}









