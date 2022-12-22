//
//  StatsLineChart.swift
//  Fokus
//
//  Created by Tb. Daffa Amadeo Zhafrana on 22/12/22.
//

import Foundation
import UIKit
import Charts
import SnapKit

class StatsLineChart : UIView {
    
    private let lineChart : LineChartView = {
        let lineChart = LineChartView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-80, height: 310))
        lineChart.backgroundColor = .darkGrey
        lineChart.isUserInteractionEnabled = false

        lineChart.rightAxis.enabled = false
    
        lineChart.leftAxis.labelFont = .atkinsonRegular(size: 14)!
        lineChart.leftAxis.labelTextColor = .whiteFokus
        lineChart.leftAxis.setLabelCount(5, force: true)
        lineChart.leftAxis.labelPosition = .outsideChart
        lineChart.leftAxis.axisMinimum = 0
        lineChart.leftAxis.axisLineColor = .turq

        lineChart.xAxis.labelFont = .atkinsonRegular(size: 14)!
        lineChart.xAxis.labelTextColor = .whiteFokus
        lineChart.xAxis.setLabelCount(6, force: true)
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.axisMaximum = 30
        lineChart.xAxis.axisMinimum = 1
        lineChart.xAxis.axisLineColor = .turq
        
        return lineChart
    }()
    
    private let noDataLabel : UILabel = {
        let label = UILabel()
        label.text = "No data available"
        label.font = .atkinsonRegular(size: .large)
        label.textColor = .whiteFokus
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-40, height: 350))
        backgroundColor = .darkGrey
        layer.cornerRadius = 8
        
        addSubview(noDataLabel)
        addSubview(lineChart)
        
        configureConstraints()
    }
    
    func configureConstraints(){
        
        lineChart.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.width.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        noDataLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func setData(data: LineChartData){
        
        if data.entryCount == 0 {
            lineChart.isHidden = true
            return
        }
        
        lineChart.isHidden = false
        lineChart.data = data
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
 
