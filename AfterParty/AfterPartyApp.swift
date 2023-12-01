//
//  AfterPartyApp.swift
//  AfterParty
//
//  Created by Radek Vala on 03.11.2023.
//

import SwiftUI

@main
struct AfterPartyApp: App {
    
    //@State private var drinkIntakeList: DrinkIntakeList = DrinkIntakeList()
    @StateObject private var dataController = DataController.shared
    
    
    var body: some Scene {
        WindowGroup {
            DrinkIntakeListView()
                .environment(\.managedObjectContext, dataController.container.viewContext )
        }
    }
}
