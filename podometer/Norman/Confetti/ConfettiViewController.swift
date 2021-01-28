//
//  ConfettiViewController.swift
//  podometer
//
//  Created by norm on 28/01/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import UIKit

class ConfettiViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        bouton.layer.cornerRadius = 25
        lanceur = Lanceur(layer: self)
        lanceur.setup(frame: view.frame)
        view.layer.addSublayer(lanceur)

    }


    @IBOutlet weak var bouton: UIButton!
   
    var lanceur: Lanceur!

    
    @IBAction func boutonAction(_ sender: Any) {
        lanceur.lancerConfettis()
        bouton.isEnabled = false
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (t) in
            self.lanceur.emitterCells?.removeAll()
            self.bouton.isEnabled = true
        }
    }
    
    
    
    
    
    
}





