//
//  AfterPartyApp.swift
//  AfterParty
//
//  Created by Radek Vala on 03.11.2023.
//

import SwiftUI

@main
struct AfterPartyApp: App {
    
    @State private var drinkIntakeList: DrinkIntakeList = DrinkIntakeList()
    
    var body: some Scene {
        WindowGroup {
            DrinkIntakeListView()
                .environment(drinkIntakeList)
        }
    }
}
