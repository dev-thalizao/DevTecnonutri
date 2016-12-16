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
    let name: String
    let imageUrl: String
    let generalGoal: String
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.imageUrl = json["image"].stringValue
        self.generalGoal = json["general_goal"].stringValue
    }
}
