//
//  Podometer.swift
//  podometer
//
//  Created by Mohamed dennoun on 02/02/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import CoreMotion

class PodometerModel {
    
    static let pedometer = CMPedometer()
    
    let distence: NSNumber
    let step: NSNumber
    let floorAscended: NSNumber
    let floorDescended: NSNumber
    let startDate: Date
    let endDate: Date
                   
    
    init(distence: NSNumber, step: NSNumber, floorAscended: NSNumber, floorDescended: NSNumber, startDate: Date, endDate: Date) {
        self.distence = distence
        self.step = step
        self.floorAscended = floorAscended
        self.floorDescended = floorDescended
        self.startDate = startDate
        self.endDate = endDate
        
    }
    
    
    
    static func todayData() -> PodometerModel? {
        
        var modele: PodometerModel?
        if CMPedometer.isStepCountingAvailable() {
            let calendar = Calendar.current
            self.pedometer.queryPedometerData(from: calendar.startOfDay(for: Date()), to: Date()) { (data, error) in
               
                DispatchQueue.main.async{
                   
                    guard let distence = data?.distance,
                    let step = data?.numberOfSteps,
                    let floorAscended = data?.floorsAscended,
                    let floorDescended = data?.floorsDescended,
                    let startDate = data?.startDate,
                    let endDate = data?.endDate else {
                        return
                        
                    }

                    
                    
                    modele = PodometerModel(distence: distence, step: step, floorAscended: floorAscended, floorDescended: floorDescended, startDate: startDate, endDate: endDate)
                    
                }
                
            }
        }
        
        return modele
    }
    
    static func data(startDate: Date, endDate: Date) -> PodometerModel? {
        
        var podometer: PodometerModel?
        if CMPedometer.isStepCountingAvailable() {
            let calendar = Calendar.current
            pedometer.queryPedometerData(from: calendar.startOfDay(for: startDate), to: endDate) { (data, error) in
               
                DispatchQueue.main.async{
                   
                    guard let distence = data?.distance,
                    let step = data?.numberOfSteps,
                    let floorAscended = data?.floorsAscended,
                    let floorDescended = data?.floorsDescended,
                    let startDate = data?.startDate,
                    let endDate = data?.endDate else {
                        return
                        
                    }

                    
                    
                    podometer = PodometerModel(distence: distence, step: step, floorAscended: floorAscended, floorDescended: floorDescended, startDate: startDate, endDate: endDate)
                    
                }
                
            }
        }
        
        return podometer
    }
    
    
    
    
}



