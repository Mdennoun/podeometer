//
//  UpgradeViewController.swift
//  podometer
//
//  Created by Mohamed dennoun on 31/01/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import UIKit

class UpgradeViewController: UIViewController {

    @IBOutlet var badgeText: UILabel!
    @IBOutlet var imageView: UIImageView!
    var badgeName: String?
    var bText: String?
    

    class func newInstance(badgeName: String, badgeText: String) -> UpgradeViewController {
        let vc = UpgradeViewController()
        vc.badgeName = badgeName
        vc.bText = badgeText
        return vc
        
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let bName = badgeName else {
            return
        }
        self.imageView.image = UIImage(imageLiteralResourceName: bName)
        self.badgeText.text = bText

    }

}
