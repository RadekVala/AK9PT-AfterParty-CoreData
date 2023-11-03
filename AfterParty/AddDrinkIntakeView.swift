//
//  AddDrinkIntakeView.swift
//  AfterParty
//
//  Created by Radek Vala on 03.11.2023.
//

import SwiftUI

struct AddDrinkIntakeView: View {
    
    var items: DrinkIntakeList
    @Binding var isPresented: Bool
    @State var selectedDrinkId = UUID()
    @State var drinkTypes = DrinkType.defaultDrinkTypes()
    @State var selectedVolume: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select type of drink")) {
                    VStack {
                        Picker("Select a Drink Type", selection: $selectedDrinkId) {
                            ForEach(drinkTypes , id: \.self) { drink in
                                Text(drink.name)
                                    .tag(drink.id)
                            }
                        }
                        
                        
                    }
                }
                Section(header: Text("Choose volume")) {
                    TextField("Volume in litres", text: $selectedVolume)
                        .keyboardType(.decimalPad)
                    
                }
            }
            .navigationTitle("Add Drink Intake")
            .navigationBarItems(
                trailing: Button("Save") {
                    
                    if !selectedVolume.isEmpty {
                        
                        let filteredDrinkTypes = drinkTypes.filter { $0.id == selectedDrinkId }
                        
                        
                        
                        let drinkIntake = DrinkIntake(
                            total: 1,
                            volume: decimalNumFormater(stringNumber: selectedVolume) ?? 0.0,
                            drinkType: filteredDrinkTypes.first ?? DrinkType.defaultDrinkTypes()[0])
                        
                        items.drinks.append(drinkIntake)
                         
                        isPresented = false
                    }
                    
                }
            )
        }
    }
}


/*
 #Preview {
 AddDrinkIntakeView(items: DrinkIntakeList(), isPresented: Binding(true))
 }
 
 */
