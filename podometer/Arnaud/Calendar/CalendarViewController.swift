//
//  CalendarViewController.swift
//  podometer
//
//  Created by Arnaud Salomon on 09/02/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import UIKit
import CoreMotion

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var collection_view: UICollectionView!
    @IBOutlet weak var distLabel: UILabel!
    
    class func newInstance(calendar: Calendar) -> CalendarViewController {
        let vc = CalendarViewController()
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collection_view.delegate = self
        collection_view.dataSource = self
        
  
        print(Date.getInstallationDate())
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CalendarCollectionViewCell", bundle: bundle)
        
        collection_view.register(nib, forCellWithReuseIdentifier: "COLLECTION_CELL_CALENDAR_IDENTIFER")
        let podo = PodometerModel.todayData()
        if(podo != nil) {
            setLabelValue(podometer: podo!)
        }
        
                
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collection_view.dequeueReusableCell(withReuseIdentifier: "COLLECTION_CELL_CALENDAR_IDENTIFER", for: indexPath) as! CalendarCollectionViewCell
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dayBefore = datePastDays(numberOfDayBefore: -indexPath.row)
        
        
    }
    
    func getDataPodometer(date: Date) -> PodometerModel {
        return PodometerModel.data(startDate: Date.getInstallationDate(), endDate: date)!
    }

    func datePastDays(numberOfDayBefore: Int) -> Date {
        let calendar = Calendar.current
        return calendar.date(byAdding: .day, value: -numberOfDayBefore, to: Date())!
    }
    
    func setLabelValue(podometer: PodometerModel) ->Void{
        distLabel.text = podometer.distence.stringValue
        stepLabel.text = podometer.step.stringValue
    }
}
