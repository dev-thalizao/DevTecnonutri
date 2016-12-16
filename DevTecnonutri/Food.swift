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

struct Food {
    let description: String
    let measure: String
    let amount: Int
    let weith: Float
    let energy: Float
    let carbohydrate: Float
    let fat: Float
    let protein: Float
}
