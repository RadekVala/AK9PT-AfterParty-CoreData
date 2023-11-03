//
//  DrinkIntakeList.swift
//  AfterParty
//
//  Created by Radek Vala on 03.11.2023.
//

import SwiftUI

@Observable class DrinkIntakeList {
    
    var drinks: [DrinkIntake] = [
        .init(total: 1, volume: 0.5, drinkType: DrinkType.defaultDrinkTypes()[0]),
        .init(total: 2, volume: 0.3, drinkType: DrinkType.defaultDrinkTypes()[1])
    ]
}
