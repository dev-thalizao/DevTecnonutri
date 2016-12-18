//
//  FeedTableViewCell.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import UIKit
import YYWebImage

protocol FeedTableViewCellDelegate {
    func didTapProfileImage(user: User)
}

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileGoal: UILabel!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealDate: UILabel!
    @IBOutlet weak var mealEnergy: UILabel!
    @IBOutlet weak var mealStateHeight: NSLayoutConstraint!
    var item: Item!
    var delegate: FeedTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 1.33
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale;
        
        // Circle image
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        self.profileImage.clipsToBounds = true
        
        // Tap gesture
        self.profileButton.addTarget(self, action: #selector(tapProfileImage), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(item: Item){
        self.item = item
        self.profileName.text = item.user.name
        self.profileGoal.text = item.user.generalGoal
        
        self.profileImage.yy_setImage(with: URL(string: item.user.imageUrl), placeholder: UIImage(named: "profile_placeholder"), options: .setImageWithFadeAnimation, completion: nil)
        self.mealImage.yy_setImage(with: URL(string: item.imageUrl), options: .setImageWithFadeAnimation)
        
        self.mealImage.contentMode = .scaleToFill
        self.mealDate.text = "Data da refeição \(DateUtils.formatToPattern(date: item.date, pattern: "dd/MM/yyyy"))"
        self.mealEnergy.text = "\(NumberUtils.formatNumberToHumanReadable(number: item.totalNutrients.energy)) kcal"
        self.mealStateHeight.constant = 56
    }
    
    func setupCellForDetail(item: Item){
        setupCell(item: item)
        // Hide date and kcal
        self.mealStateHeight.constant = 0
    }
    
    func tapProfileImage(){
        delegate?.didTapProfileImage(user: item.user)
    }
}
