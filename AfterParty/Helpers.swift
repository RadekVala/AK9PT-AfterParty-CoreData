//
//  Helpers.swift
//  AfterParty
//
//  Created by Radek Vala on 03.11.2023.
//

import SwiftUI

func alcoholIntakeRecalculate(drinkIntake: DrinkIntakeEntity) -> Double {
    
    //Promile = (alcohol intake in grams / (body weight in kgs * distribution coef - 0.68)) * 100
    let storedWeight = UserDefaults.standard.integer(forKey: "weight")
    var bodyWeight = 75
    if storedWeight > 0 {
        bodyWeight = storedWeight
    }
    
    let distrCoef = 0.68
    let drinksCount = Double(drinkIntake.total)
    
    let alcoholIntake = (drinkIntake.drinkType?.alcoholVolume ?? 0.0) * drinkIntake.volume * 10 * drinksCount
    let promile = (alcoholIntake / (Double(bodyWeight) *  distrCoef))
    
    return promile
}


func totalIntake(drinkList: FetchedResults<DrinkIntakeEntity>) -> Double {
    var sum = 0.0
    for drink in drinkList {
        sum += alcoholIntakeRecalculate(drinkIntake: drink)
    }
    return sum
}
 

func promileInTime(totalPromile: Double, hours: Double) -> Double {
    let result = totalPromile - (0.15 * hours)
    
    if result < 0 {
        return 0
    }
    return result
}

func decimalNumFormater(stringNumber: String) -> Double? {
    let formatter = NumberFormatter()
    formatter.decimalSeparator = ","
    let grade = formatter.number(from: stringNumber)
    
    if let doubleGrade = grade?.doubleValue {
        return doubleGrade
    } else {
        return nil
    }
}
