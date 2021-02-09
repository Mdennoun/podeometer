//
//  StoreDetailViewController.swift
//  Magasin
//
//  Created by Mohamed dennoun on 22/11/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit
import CoreLocation //Framework geoloc

class StoreDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet var adresse: UILabel?
    @IBOutlet var badgeLevelCollectionView: UICollectionView!
    var nameTxt = "";

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = nameTxt
        
        badgeLevelCollectionView.delegate = self
        badgeLevelCollectionView.dataSource = self
        self.badgeLevelCollectionView.isPagingEnabled = true;

        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: bundle)
        badgeLevelCollectionView.register(nib, forCellWithReuseIdentifier: "COLLECTION_CELL_PRODUCT_IDENTIFER")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Config.badgeLevels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "COLLECTION_CELL_PRODUCT_IDENTIFER", for: indexPath) as! ProductCollectionViewCell
        cell.photoProduct.image = Config.badgeLevels[indexPath.item].image
        return cell
    }
    
        

    
    


    

}
