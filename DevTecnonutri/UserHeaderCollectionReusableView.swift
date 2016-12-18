//
//  UserHeaderCollectionReusableView.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/16/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import UIKit
import YYWebImage

class UserHeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userGoal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
