//
//  Config.swift
//  podometer
//
//  Created by Arnaud Salomon on 01/02/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import Foundation

class Config {
    
    static let level: [Int] = [0, 10000, 50000, 100000, 170000, 220000, 330000, 440000, 550000]
    
    static let badgeDays: [BadgeDay] = [ BadgeDay(day: 7, text: "7 Jours !"),
                                       BadgeDay(day: 14, text: "14 Jours !"),
                                       BadgeDay(day: 30,text: "30 Jours !"),
                                       BadgeDay(day: 60,text: "60 jours !"),
                                       BadgeDay(day: 100, text: "100 jours !"),
                                       BadgeDay(day: 180,text: "180 Jours !"),
                                       BadgeDay(day: 365, text: "365 Jours !!") ]
    
}

