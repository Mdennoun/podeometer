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
import DropDown

class NavViewController: UITabBarController {


    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view, typically from a nib.
        firstUser()
        self.navigationItem.title = "Podometre"
        view.backgroundColor = UIColor.white
        tabBar.barTintColor = UIColor(red: 91/255, green: 128/255, blue: 185/255, alpha: 1)
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = .red

        // The view to which the drop down will appear on
        dropDown.anchorView = view // UIView or UIBarButtonItem

        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["Modifier Profil", "Mes badge", "Tester le tracage Map"]
        let ctrls = [UserFormViewController(), StoreDetailViewController(), MapViewController()]
        dropDown.direction = .any
        
        // Top of drop down will be below the anchorView
        dropDown.bottomOffset = CGPoint(x: 0, y:((dropDown.anchorView?.plainView.bounds.height)!-182))
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.navigationController?.pushViewController(ctrls[index], animated: true)
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu.png"), style: .plain, target: self, action: #selector(addTapped))
        setupTabBar()
    }
    
    @objc func addTapped(sender: UIBarButtonItem) {
        // Function body goes here
      
            dropDown.show()
      
    }
    
    func firstUser(){
        if(UIApplication.isFirstLaunch()){
                   let user = User.new(named: "Non renseigner", age: Int32(0), height: 0, weight: 0)
                   User.saveOne(user: user)
        }
    }
    
    
    
     func setupTabBar() {
        
        
        let homeController = ConfettiViewController()
        homeController.tabBarItem.image = UIImage(imageLiteralResourceName: "home")
        homeController.tabBarItem.title = "Aujourd'hui"
            
        let detailController = RoutingViewController()
        //UpgradeViewController.newInstance(badgeName: "lib_ac_badge_level_1", badgeText: "7 jours")
        detailController.tabBarItem.image = UIImage(imageLiteralResourceName: "map")
        detailController.tabBarItem.title = "Parcours"
        
        let profileController = ProfileViewController()
        profileController.tabBarItem.image = UIImage(imageLiteralResourceName: "accunt")
        profileController.tabBarItem.title = "Profile"
        self.viewControllers = [homeController, detailController, profileController]
    
        
                
    }
             
}
