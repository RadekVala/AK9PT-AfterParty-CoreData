//
//  DrinkType.swift
//  AfterParty
//
//  Created by Radek Vala on 03.11.2023.
//

import SwiftUI

struct DrinkType: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var alcoholVolume: Double
    
    static func defaultDrinkTypes() -> [DrinkType] {
        
        let drinkTypes: [DrinkType] = [
            .init(name: "Beer 10", alcoholVolume: 4.0),
            .init(name: "Beer 12", alcoholVolume: 5.0),
            .init(name: "Wine", alcoholVolume: 12),
            .init(name: "Slivovitz", alcoholVolume: 50),
        ]
        
        return drinkTypes
    }
}

