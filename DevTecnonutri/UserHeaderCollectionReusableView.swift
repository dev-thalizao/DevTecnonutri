//
//  UserHeaderCollectionReusableView.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/16/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import UIKit
import YYWebImage
import Foundation

class UserHeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userGoal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        
        // Circle image
        self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2
        self.userImage.clipsToBounds = true
    }
    
    func setupCell(user: User){
        self.userImage.yy_setImage(with: URL(string: user.imageUrl), placeholder: UIImage(named: "profile_placeholder"), options: .setImageWithFadeAnimation, completion: nil)
        self.userName.text = user.name
        self.userGoal.text = user.generalGoal
    }
}
