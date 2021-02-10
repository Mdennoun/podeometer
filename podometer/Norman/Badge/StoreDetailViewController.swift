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

    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var photoLevel: UIImageView!

    
    @IBOutlet var badgeLevelCollectionView: UICollectionView!
    @IBOutlet weak var badgeDistanceCollectionView: UICollectionView!
    @IBOutlet weak var badgeDayCollectionView: UICollectionView!
    @IBOutlet weak var badgeStepCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        levelLabel.text = (User.getBadgeLevel()).last?.text
        photoLevel.image = (User.getBadgeLevel()).last?.image
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: bundle)
        
        badgeLevelCollectionView.delegate = self
        badgeLevelCollectionView.dataSource = self
        badgeLevelCollectionView.register(nib, forCellWithReuseIdentifier: "COLLECTION_CELL_PRODUCT_IDENTIFER")
        
        
        badgeDistanceCollectionView.delegate = self
        badgeDistanceCollectionView.dataSource = self
        badgeDistanceCollectionView.register(nib, forCellWithReuseIdentifier: "COLLECTION_CELL_PRODUCT_IDENTIFER")
        
        badgeDayCollectionView.delegate = self
        badgeDayCollectionView.dataSource = self
        badgeDayCollectionView.register(nib, forCellWithReuseIdentifier: "COLLECTION_CELL_PRODUCT_IDENTIFER")
        
        badgeStepCollectionView.delegate = self
        badgeStepCollectionView.dataSource = self
        badgeStepCollectionView.register(nib, forCellWithReuseIdentifier: "COLLECTION_CELL_PRODUCT_IDENTIFER")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.badgeLevelCollectionView: return Config.badgeLevels.count
            
        case self.badgeDistanceCollectionView: return Config.badgeDistance.count
            
        case self.badgeDayCollectionView: return Config.badgeDays.count
            
        case self.badgeStepCollectionView: return Config.badgeSteps.count
   
        default:
            break
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "COLLECTION_CELL_PRODUCT_IDENTIFER", for: indexPath) as! ProductCollectionViewCell
        cell.xpBar.isHidden = true
        
        let curXP = 20000

        cell.photoProduct.clipsToBounds = true
        switch collectionView {
        case self.badgeLevelCollectionView: if indexPath[1] < User.getBadgeLevel().count {
            cell.photoProduct.image = Config.badgeLevels[indexPath.item].image
            cell.photoLock.isHidden = true
        }
        else {
            if indexPath[1] == User.getBadgeLevel().count{
                let nextIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
                let nextXP = Config.badgeLevels[nextIndexPath.item].number
                cell.xpBar.progress = Float(curXP)/Float(nextXP)
                cell.xpBar.isHidden = false
            }
        
        cell.photoLock.isHidden = false
        cell.photoProduct.image = convertToGrayScale(image: Config.badgeLevels[indexPath.item].image)
        }
        
        case self.badgeDistanceCollectionView: if indexPath[1] < User.getBadgeDistance().count {
            cell.photoProduct.image = Config.badgeDistance[indexPath.item].image
            cell.photoLock.isHidden = true
        }
        else {
        cell.photoLock.isHidden = false
        cell.photoProduct.image = convertToGrayScale(image: Config.badgeDistance[indexPath.item].image)
        }
        
        case self.badgeDayCollectionView: if indexPath[1] < User.getBadgeDay().count {
            cell.photoProduct.image = Config.badgeDays[indexPath.item].image
            cell.photoLock.isHidden = true
        }
        else {
        cell.photoLock.isHidden = false
        cell.photoProduct.image = convertToGrayScale(image: Config.badgeDays[indexPath.item].image)
        }
        
        case self.badgeStepCollectionView: if indexPath[1] < User.getBadgeStep().count {
            cell.photoProduct.image = Config.badgeSteps[indexPath.item].image
            cell.photoLock.isHidden = true
        }
        else {
        cell.photoLock.isHidden = false
        cell.photoProduct.image = convertToGrayScale(image: Config.badgeSteps[indexPath.item].image)
        }

        default:
            break
        }
        
        return cell
    }
    
    
    func convertToGrayScale(image: UIImage) -> UIImage {
        let filter: CIFilter = CIFilter(name: "CIPhotoEffectMono")!
        filter.setDefaults()
        filter.setValue(CoreImage.CIImage(image: image)!, forKey: kCIInputImageKey)

        return UIImage(cgImage: CIContext(options:nil).createCGImage(filter.outputImage!, from: filter.outputImage!.extent)!)
    }

}
