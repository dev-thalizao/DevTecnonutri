//
//  User.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    let id: NSNumber
    let name: String
    let imageUrl: String
    let generalGoal: String
    let items: [Item]
    
    init(json: JSON) {
        self.id = json["id"].numberValue
        self.name = json["name"].stringValue
        self.imageUrl = json["image"].stringValue
        self.generalGoal = json["general_goal"].stringValue
        
        self.items = json["items"].arrayValue.map({ (itemJson) -> Item in
            return Item(json: itemJson)
        })
    }
}
