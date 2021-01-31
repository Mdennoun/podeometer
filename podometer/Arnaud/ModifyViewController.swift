//
//  ModifyViewController.swift
//  podometer
//
//  Created by Arnaud Salomon on 30/01/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import UIKit

class ModifyViewController: UIViewController {
    @IBOutlet weak var pseudoEdt: UITextField!
    @IBOutlet weak var agEdt: UITextField!
    @IBOutlet weak var sizEdt: UITextField!
    @IBOutlet weak var weightEdt: UITextField!
    
    
    @IBAction func saveBtn(_ sender: Any) {
        guard let userPseudo = pseudoEdt.text,
              let userAge = agEdt.text,
              let userHeight = sizEdt.text,
              let userWeight = weightEdt.text else {
                return
        }
        guard let age = Int(userAge),
              let height = Double(userHeight),
              let weight = Double(userWeight) else {
                return
        }
        updateUser(named: userPseudo, age: age, height: height, weight: weight)
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)

    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print(User.all.count)
        // Do any additional setup after loading the view.
    }
    
    private func updateUser(named pseudo: String,  age: Int, height: Double, weight: Double) {
        let user = User(context: AppDelegate.viewContext)
        user.pseudo = pseudo
        user.age = Int32(age)
        user.height = height
        user.weight = weight
        user.curlevel = 0
        user.curxp = 0
        user.curimc = 0
        user.total_step = 0
        user.total_distance = 0
        try? AppDelegate.viewContext.save()
        
    }



}
