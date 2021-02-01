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

    static let badgeDays: [Badge] =  [Badge(number: 7, text: "7 Jours !"),
                                    Badge(number: 14, text: "14 Jours !"),
                                    Badge(number: 30,text: "30 Jours !"),
                                    Badge(number: 60,text: "60 jours !"),
                                    Badge(number: 100, text: "100 jours !"),
                                    Badge(number: 180,text: "180 Jours !"),
                                    Badge(number: 365, text: "365 Jours !!")]

    static let badgeSteps: [Badge] = [Badge(number: 3000, text: "Loin du canapé"),
                                    Badge(number: 7000, text: "Rester en forme"),
                                    Badge(number: 10000,text: "Journée saine"),
                                    Badge(number: 14000,text: "Journée minceur"),
                                    Badge(number: 20000, text: "Randonner"),
                                    Badge(number: 30000,text: "Explorateur"),
                                    Badge(number: 40000, text: "Héros"),
                                    Badge(number: 60000, text: "Conquérant")]

}
