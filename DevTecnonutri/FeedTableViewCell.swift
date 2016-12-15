//
//  FeedTableViewCell.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var rootView: UIView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileGoal: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealDate: UILabel!
    @IBOutlet weak var mealEnergy: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rootView.layer.borderWidth = 0.3
        rootView.layer.borderColor = UIColor.lightGray.cgColor
        rootView.layer.cornerRadius = 1.33
        
        // Circle image
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.layer.borderWidth = 0.5
        profileImage.layer.borderColor = UIColor.lightGray.cgColor
        profileImage.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
