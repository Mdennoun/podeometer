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
        let firstUseApp = isFirstUse()
        if(firstUseApp) {
            //self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        }

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
        
        saveUser(named: userPseudo, age: age, height: height, weight: weight)
        
    }
    
    private func saveUser(named pseudo: String,  age: Int, height: Double, weight: Double) {
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
    
    private func isFirstUse() -> Bool {
        return true
        
    }
    
    
    @IBAction func updateBtn(_ sender: Any) {
       
        self.navigationController?.pushViewController(ModifyViewController(), animated: true)
    }
    
    

}
