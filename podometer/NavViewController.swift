//
//  HomeViewController.swift
//  Podomètre
//
//  Created by Mohamed dennoun on 22/01/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData
import CoreMotion

class NavViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.white
        tabBar.barTintColor = UIColor(red: 91/255, green: 128/255, blue: 185/255, alpha: 1)
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = .red
        
        setupTabBar()
    }
    
    
    
     func setupTabBar() {
        
        
        let homeController = UINavigationController(rootViewController: UserFormViewController())
        homeController.tabBarItem.image = UIImage(imageLiteralResourceName: "home")
        homeController.tabBarItem.title = "Aujourd'hui"
            
        let detailController = UINavigationController(rootViewController: UserFormViewController())
        detailController.tabBarItem.image = UIImage(imageLiteralResourceName: "home")
        detailController.tabBarItem.title = "Rapport"
        
        let profileController = UINavigationController(rootViewController:  ProfileViewController())
        profileController.tabBarItem.image = UIImage(imageLiteralResourceName: "home")
        profileController.tabBarItem.title = "Profile"
        self.viewControllers = [homeController, detailController, profileController]
    
        
                
    }
             
}
