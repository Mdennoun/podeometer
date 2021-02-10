//
//  BadgeDays.swift
//  podometer
//
//  Created by Arnaud Salomon on 01/02/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import Foundation
import UIKit

class Badge {
    let number : Int
    let text : String
    let image : UIImage


    init(number: Int, text: String, image: UIImage ) {
        self.number = number
        self.text = text
        self.image = image

    }

}
