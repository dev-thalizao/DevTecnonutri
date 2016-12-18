//
//  Food.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/16/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//
/*
"foods": [
{
"description": "Purê de batata",
"measure": "Colher de Arroz",
"amount": 1,
"weight": 80,
"energy": 92.128,
"carbohydrate": 14.208000000000002,
"fat": 3.4880000000000004,
"protein": 1.4480000000000002
}
*/
 
import Foundation
import SwiftyJSON

struct Food {
    let description: String
    let measure: String
    let amount: Int
    let weight: NSNumber
    let energy: NSNumber
    let carbohydrate: NSNumber
    let fat: NSNumber
    let protein: NSNumber
    
    init(json: JSON){
        self.description = json["description"].stringValue
        self.measure = json["measure"].stringValue
        self.amount = json["amount"].intValue
        self.weight = json["weight"].numberValue
        self.energy = json["energy"].numberValue
        self.carbohydrate = json["carbohydrate"].numberValue
        self.fat = json["fat"].numberValue
        self.protein = json["protein"].numberValue
    }
}
