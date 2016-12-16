//
//  FeedDetailTableViewCell.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/16/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import UIKit

class FeedDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    //  "amount", "measure", "weight"
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var energyLabel: UILabel!
    @IBOutlet weak var carbohydrateLabel: UILabel!
    @IBOutlet weak var proteinLabel: UILabel!
    @IBOutlet weak var fatLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(food: Food){
        
    }
}
