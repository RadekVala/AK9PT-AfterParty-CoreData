//
//  DrinkIntake.swift
//  AfterParty
//
//  Created by Radek Vala on 03.11.2023.
//

import SwiftUI

struct DrinkIntake: Identifiable {
    let id = UUID()
    var total: Int
    var volume: Double
    var drinkType: DrinkType
    
}
