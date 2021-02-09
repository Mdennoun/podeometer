//
//  Config.swift
//  podometer
//
//  Created by Arnaud Salomon on 01/02/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//


import Foundation
import UIKit

class Config {

    static let badgeLevels: [Badge] =    [Badge(number: 10000, text: "Level 1",image: UIImage(named: "lib_ac_badge_level_1")!),
                                          Badge(number: 50000,text: "Level 2", image: UIImage(named: "lib_ac_badge_level_2")!),
                                          Badge(number: 100000,text: "Level 3", image: UIImage(named: "lib_ac_badge_level_3")!),
                                          Badge(number: 170000, text: "Level 4",image: UIImage(named: "lib_ac_badge_level_4")!),
                                          Badge(number: 220000,text: "Level 5", image: UIImage(named: "lib_ac_badge_level_5")!),
                                          Badge(number: 330000, text: "Level 6", image: UIImage(named: "lib_ac_badge_level_6")!),
                                          Badge(number: 440000, text: "Level 7", image: UIImage(named: "lib_ac_badge_level_7")!),
                                          Badge(number: 550000, text: "Level 8", image: UIImage(named: "lib_ac_badge_level_8")!)]
        
    static let badgeDays: [Badge] =  [Badge(number: 7, text: "7 Jours !",  image: UIImage(named: "lib_ac_badge_days_fg_1")!),
                                      Badge(number: 14, text: "14 Jours !",image: UIImage(named: "lib_ac_badge_days_fg_2")!),
                                      Badge(number: 30,text: "30 Jours !", image: UIImage(named: "lib_ac_badge_days_fg_3")!),
                                      Badge(number: 60,text: "60 jours !", image: UIImage(named: "lib_ac_badge_days_fg_4")!),
                                      Badge(number: 100, text: "100 jours !",image: UIImage(named: "lib_ac_badge_days_fg_5")!),
                                      Badge(number: 180,text: "180 Jours !", image: UIImage(named: "lib_ac_badge_days_fg_6")!),
                                      Badge(number: 365, text: "365 Jours !!", image: UIImage(named: "lib_ac_badge_days_fg_7")!)]

    static let badgeSteps: [Badge] = [Badge(number: 3000, text: "Loin du canapé", image: UIImage(named: "step_badge_0")!),
                                      Badge(number: 7000, text: "Rester en forme",image: UIImage(named: "step_badge_1")!),
                                      Badge(number: 10000,text: "Journée saine",image: UIImage(named: "step_badge_2")!),
                                      Badge(number: 14000,text: "Journée minceur",image: UIImage(named: "step_badge_3")!),
                                      Badge(number: 20000, text: "Randonner",image: UIImage(named: "step_badge_4")!),
                                      Badge(number: 30000,text: "Explorateur",image: UIImage(named: "step_badge_5")!),
                                      Badge(number: 40000, text: "Héros",image: UIImage(named: "step_badge_6")!),
                                      Badge(number: 60000, text: "Conquérant",image: UIImage(named: "step_badge_7")!)]
    
    static let badgeDistance: [Badge] = [Badge(number: 5, text: "Petite randonnée",image: UIImage(named: "lib_ac_badge_distance_fg_km_1")!),
                                       Badge(number: 10, text: "Vacance Romaines",image: UIImage(named: "lib_ac_badge_distance_fg_km_2")!),
                                       Badge(number: 20, text: "Conquérir l'Olympe",image: UIImage(named: "lib_ac_badge_distance_fg_km_3")!),
                                       Badge(number: 42, text: "Marathon",image: UIImage(named: "lib_ac_badge_distance_fg_km_4")!),
                                       Badge(number: 100, text: "100 Km",image: UIImage(named: "lib_ac_badge_distance_fg_km_5")!),
                                       Badge(number: 220, text: "De Londres à Paris",image: UIImage(named: "lib_ac_badge_distance_fg_km_6")!),
                                       Badge(number: 450, text: "De Boston à philladelphie",image: UIImage(named: "lib_ac_badge_distance_fg_km_7")!),
                                       Badge(number: 800, text: "Huit cents kilomètres",image: UIImage(named: "lib_ac_badge_distance_fg_km_8")!),
                                       Badge(number: 2000, text: "Sahara",image: UIImage(named: "lib_ac_badge_distance_fg_km_9")!),
                                       Badge(number: 6300, text: "Vers le centre de la Terre",image: UIImage(named: "lib_ac_badge_distance_fg_km_10")!)]

}
