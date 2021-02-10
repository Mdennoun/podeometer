//
//  ProductCollectionViewCell.swift
//  Magasin
//
//  Created by Mohamed dennoun on 22/11/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    

    @IBOutlet weak var photoProduct: UIImageView!
    @IBOutlet weak var photoLock: UIImageView!
    @IBOutlet weak var xpBar: UIProgressView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
