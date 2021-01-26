//
//  ProfileViewController.swift
//  podometer
//
//  Created by Mohamed dennoun on 25/01/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var pseudo: UILabel!
    @IBOutlet var age: UILabel!
    @IBOutlet var weight: UILabel!
    @IBOutlet var height: UILabel!
    @IBOutlet var curStep: UILabel!
    @IBOutlet var curDistence: UILabel!
    @IBOutlet var level: UILabel!
    @IBOutlet var curIMC: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Profil"
        displayUserData()

    }
    
    private func displayUserData() {
        
        for user in User.all { // <-- Ici, on utilise maintenant Person.all
            if let pseudo = user.pseudo {
                self.pseudo.text = pseudo
            }
            self.age.text = String(user.age)
            self.weight.text = String(user.weight)
            self.height.text = String(user.height)
            self.curStep.text = String(user.total_step)
            self.curDistence.text  = String(user.total_distance)
            self.level.text = String(user.curlevel)
            self.curIMC.text = String(user.curimc)
            print(user)
                
            
            
        }
    }



}
