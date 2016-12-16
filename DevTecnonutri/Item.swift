//
//  Item.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Item {
    let feedHash: String
    let imageUrl: String
    let mealType: Meal
    let date: Date
    let energy: Float
    let user: User
    
    init(json: JSON) {
        self.feedHash = json["feedHash"].stringValue
        self.imageUrl = json["image"].stringValue
        self.mealType = Meal(rawValue: json["meal"].intValue)!
        self.date = DateUtils.formatDate(stringDate: json["date"].stringValue)
        self.energy = json["energy"].floatValue
        self.user = User(json: json["profile"])
    }
}
