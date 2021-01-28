//
//  IMCViewController.swift
//  podometer
//
//  Created by norm on 28/01/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import UIKit
import Charts
import TinyConstraints


class IMCViewController: UIViewController {

    
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemBlue
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
    }

    
    
/*
    func calculIMC() -> Double {
        return user.weight / ((user.height / 100) * (user.height / 100))
    }
 */

}
