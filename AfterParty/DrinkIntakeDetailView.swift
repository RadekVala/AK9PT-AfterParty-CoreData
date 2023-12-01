//
//  DrinkIntakeDetailView.swift
//  AfterParty
//
//  Created by Radek Vala on 03.11.2023.
//

import SwiftUI

struct DrinkIntakeDetailView: View {
    
    // Core Data persistent context
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var drinkIntake: DrinkIntakeEntity
    
    @State var alcoholIntake = 0.0
    
    var body: some View {
        VStack {
            Text(drinkIntake.drinkType?.name ?? "Drink name not set")
                .font(.headline)
                .padding()
            
            Text("Consumed: **\(drinkIntake.total)** pcs")
            Text("One psc is ***\(drinkIntake.volume, specifier: "%.2f")*** liter")
            
            Button("Drink one more"){
                drinkIntake.total += 1
                alcoholIntake = alcoholIntakeRecalculate(drinkIntake: drinkIntake)
                try? viewContext.save()
                
            }.buttonStyle(.borderedProminent)
            
            Text("\(alcoholIntake, specifier: "%.2f") ‰")
                           .padding()
        }
        .navigationTitle(drinkIntake.drinkType?.name ?? "Drink name not set")
        .onAppear {
            alcoholIntake = alcoholIntakeRecalculate(drinkIntake: drinkIntake)
        }
    }
}

/*
#Preview {
    DrinkIntakeDetailView()
}
*/
