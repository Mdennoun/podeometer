//
//  StepViewController.swift
//  Podomètre
//
//  Created by Mohamed dennoun on 23/01/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import UIKit
import CoreMotion

class StepViewController: UIViewController {
    
    @IBOutlet var distence: UILabel!
    @IBOutlet var step: UILabel!
    @IBOutlet var floorAscended: UILabel!
    @IBOutlet var floorDescended: UILabel!
    @IBOutlet var curCadence: UILabel!
    @IBOutlet var curPace: UILabel!
    @IBOutlet var startDate: UILabel!
    @IBOutlet var endDate: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        DispatchQueue.main.async{
                   
            guard let data = PodometerModel.todayData() else {return }
            
            self.distence.text = "Distance : \(data.distence)"
            self.step.text = "numberOfSteps : \(data.step)"
            self.floorAscended.text = "floorsAscended : \(data.floorAscended)"
            self.floorDescended.text = "floorsDescended : \(data.floorDescended)"
            self.curCadence.text = "currentCadence :  0"
            self.curPace.text = "currentPace : 0"
            self.startDate.text = "startDate : \(data.startDate)"
            self.endDate.text = "endDate : \(data.endDate)"
        
        
        }
        
        PodometerModel.pedometer.startUpdates(from: Date()) { (data, error) in
            
            guard let dist = data?.distance,
            let step = data?.numberOfSteps,
            let floorAsc = data?.floorsAscended,
            let floorDesc = data?.floorsDescended,
            let start = data?.startDate,
            let end = data?.endDate else {
                return
                
            }
            let cadence = data?.currentCadence?.debugDescription
            let pace = data?.currentPace?.description
            
            self.distence.text = "Distance : \(dist)"
            self.step.text = "numberOfSteps : \(step)"
            self.floorAscended.text = "floorsAscended : \(floorAsc)"
            self.floorDescended.text = "floorsDescended : \(floorDesc)"
            self.curCadence.text = "currentCadence : \(cadence ?? "-1")"
            self.curPace.text = "currentPace : \(pace ?? "-1")"
            self.startDate.text = "startDate : \(start)"
            self.endDate.text = "endDate : \(end)"
                    
        }
    
    }


}
