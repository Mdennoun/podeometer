//
//  Confetti.swift
//  podometer
//
//  Created by norm on 28/01/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import UIKit

class Confetti: CAEmitterCell {
    
    var images = [#imageLiteral(resourceName: "Box"), #imageLiteral(resourceName: "Triangle"), #imageLiteral(resourceName: "Circle")]
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        contents = images[Int(arc4random_uniform(UInt32(images.count)))].cgImage
        color = UIColor(red: floatAleatoire(), green: floatAleatoire(), blue: floatAleatoire(), alpha: 1).cgColor
        birthRate = 4
        lifetime = 10
        lifetimeRange = 3
        velocity = 100
        velocityRange = 100
        spin = 4
        spinRange = 4
        scale = 0.25
        scaleRange = 0.7
        emissionLongitude = CGFloat(Double.pi)
        emissionRange = 0.75
    }
    
    func floatAleatoire() -> CGFloat {
        return CGFloat(arc4random_uniform(255)) / 255
    }

}
