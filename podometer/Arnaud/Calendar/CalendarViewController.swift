//
//  CalendarViewController.swift
//  podometer
//
//  Created by Arnaud Salomon on 09/02/2021.
//  Copyright © 2021 Mohamed dennoun. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collection_view: UICollectionView!
    
    class func newInstance(calendar: Calendar) -> CalendarViewController {
        let vc = CalendarViewController()
        
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collection_view.delegate = self
        collection_view.dataSource = self
        
        
        let user = User.all.first
        print("OOOOOOOOOHHHHHHHHHHH")
        
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "CalendarCollectionViewCell", bundle: bundle)
        collection_view.register(nib, forCellWithReuseIdentifier: "COLLECTION_CELL_CALENDAR_IDENTIFER")
        
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let dateUser = Date.getInstallationDate()
        let date = Date()

       // let dateComp = date.distanceBetween(dateUser)
        return 10//dateComp

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collection_view.dequeueReusableCell(withReuseIdentifier: "COLLECTION_CELL_CALENDAR_IDENTIFER", for: indexPath) as! CalendarCollectionViewCell
        
        
        
        
        //cell.dayLabel.height(755.0)
        
        return cell
    }


}
