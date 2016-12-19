//
//  FeedCollectionViewCell.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/16/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import UIKit
import YYWebImage

class FeedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mealImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale;
    }
    
    func setupCell(item: Item){
        self.mealImage.yy_setImage(with: URL(string: item.imageUrl), options: .setImageWithFadeAnimation)
        self.mealImage.contentMode = .scaleToFill
    }
}
