//
//  UserDefault.swift
//  podometer
//
//  Created by Mohamed dennoun on 31/01/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import UIKit

private var firstLaunch : Bool = false

extension UIApplication {

    static func isFirstLaunch() -> Bool {
        let firstLaunchFlag = "isFirstLaunchFlag"
        let isFirstLaunch = UserDefaults.standard.string(forKey: firstLaunchFlag) == nil
        if (isFirstLaunch) {
            firstLaunch = isFirstLaunch
            UserDefaults.standard.set("false", forKey: firstLaunchFlag)
            UserDefaults.standard.synchronize()
        }
        return firstLaunch || isFirstLaunch
    }
}
