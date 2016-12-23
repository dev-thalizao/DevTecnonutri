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
        self.layer.borderWidth = 0.3
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.descriptionLabel.font = UIFont(name: "HelveticaNeue-Light", size: 18.0)
        self.amountLabel.isHidden = false
    }
    
    func setupCell(food: Food){
        self.descriptionLabel.text = food.description
        self.amountLabel.text = "\(food.amount) \(food.measure) (\(NumberUtils.formatNumberToHumanReadable(number: food.weight)) g)"
        self.energyLabel.text = "\(NumberUtils.formatNumberToHumanReadable(number: food.energy)) Kcal"
        self.carbohydrateLabel.text = "\(NumberUtils.formatNumberToHumanReadable(number: food.carbohydrate)) g"
        self.proteinLabel.text = "\(NumberUtils.formatNumberToHumanReadable(number: food.protein)) g"
        self.fatLabel.text = "\(NumberUtils.formatNumberToHumanReadable(number: food.fat)) g"
    }
    
    func setupCellForTotalNutrients(food: Food){
        setupCell(food: food)
        self.descriptionLabel.text = "Total Consumido"
        self.descriptionLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18.0)
        self.amountLabel.text = nil
        self.amountLabel.isHidden = true
    }
}
