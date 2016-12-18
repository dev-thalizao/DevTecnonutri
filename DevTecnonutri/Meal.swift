//
//  Meal.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation

public enum Meal: Int {
    case breakfast = 0, morningSnack, lunch, afternoonSnack, dinner, supper, preWorkout, postWorkout
    
    func getMealName() -> String {
        let mealName: String
        switch self {
        case .breakfast:
            mealName = "Café da manhã"
        case .morningSnack:
            mealName = "Lanche da manhã"
        case .lunch:
            mealName = "Almoço"
        case .afternoonSnack:
            mealName = "Lanche da tarde"
        case .dinner:
            mealName = "Jantar"
        case .supper:
            mealName = "Ceia"
        case .preWorkout:
            mealName = "Pré-treino"
        case .postWorkout:
            mealName = "Pós-treino"
        }
        return mealName
    }
}
