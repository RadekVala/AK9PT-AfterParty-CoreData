//
//  Helpers.swift
//  AfterParty
//
//  Created by Radek Vala on 03.11.2023.
//

import SwiftUI

func alcoholIntakeRecalculate(drinkIntake: DrinkIntake) -> Double {
    
    //Promile = (alcohol intake in grams / (body weight in kgs * distribution coef - 0.68)) * 100
    let bodyWeight = 75.0
    let distrCoef = 0.68
    let drinksCount = Double(drinkIntake.total)
    
    let alcoholIntake = drinkIntake.drinkType.alcoholVolume * drinkIntake.volume * 10 * drinksCount
    let promile = (alcoholIntake / (bodyWeight *  distrCoef))
    
    return promile
}

func totalIntake(drinkList: DrinkIntakeList) -> Double {
    var sum = 0.0
    for drink in drinkList.drinks {
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
