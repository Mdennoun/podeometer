//
//  UserFormViewController.swift
//  podometer
//
//  Created by Mohamed dennoun on 25/01/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import UIKit

class UserFormViewController: UIViewController {
    @IBOutlet var pseudo: UITextField!
    @IBOutlet var age: UITextField!
    @IBOutlet var height: UITextField!
    @IBOutlet var weight: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Création"
       

        // Do any additional setup after loading the view.
    }

    @IBAction func validate(_ sender: Any) {
        addUser()
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        
    }
    
    private func addUser() {
        guard let userPseudo = pseudo.text,
              let userAge = age.text,
              let userHeight = height.text,
              let userWeight = weight.text else {
                return
        }
        guard let age = Int(userAge),
              let height = Double(userHeight),
              let weight = Double(userWeight) else {
                return
        }
        let user = User.new(named: userPseudo, age: Int32(age), height: height, weight: weight)
        User.updateOne(user: user)
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        
    }
    

}
