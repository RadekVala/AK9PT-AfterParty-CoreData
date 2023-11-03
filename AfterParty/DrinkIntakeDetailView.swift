//
//  DrinkIntakeDetailView.swift
//  AfterParty
//
//  Created by Radek Vala on 03.11.2023.
//

import SwiftUI

struct DrinkIntakeDetailView: View {
    
    @Binding var drinkIntake: DrinkIntake
    
    @State var alcoholIntake = 0.0
    
    var body: some View {
        VStack {
            Text(drinkIntake.drinkType.name)
                .font(.headline)
                .padding()
            
            Text("Consumed: **\(drinkIntake.total)** pcs")
            Text("One psc is ***\(drinkIntake.volume, specifier: "%.2f")*** liter")
            
            Button("Drink one more"){
                drinkIntake.total += 1
                alcoholIntake = alcoholIntakeRecalculate(drinkIntake: drinkIntake)
                
            }.buttonStyle(.borderedProminent)
            
            Text("\(alcoholIntake, specifier: "%.2f") ‰")
                           .padding()
        }
        .navigationTitle(drinkIntake.drinkType.name)
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
