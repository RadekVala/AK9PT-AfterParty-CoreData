//
//  AddDrinkIntakeView.swift
//  AfterParty
//
//  Created by Radek Vala on 03.11.2023.
//

import SwiftUI

struct AddDrinkIntakeView: View {
    
    // Core Data persistent context
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \DrinkTypeEntity.name, ascending: true)
        ]
    ) private var drinkTypes: FetchedResults<DrinkTypeEntity>
    
    @State var selectedDrinkType: DrinkTypeEntity
    
    @Binding var isPresented: Bool
    //@State var selectedDrinkId = UUID()
    //@State var drinkTypes = DrinkType.defaultDrinkTypes()
    
    
    @State var selectedVolume: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select type of drink")) {
                    VStack {
                        Picker("Select a Drink Type", selection: $selectedDrinkType) {
                            ForEach(drinkTypes , id: \.self) { drink in
                                Text(drink.name ?? "Drink name not set")
                                    .tag(drink)
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
                    // save event handler
                    
                    if !selectedVolume.isEmpty {
                        
                        let drinkIntake = DrinkIntakeEntity(context: viewContext)
                        drinkIntake.id = UUID()
                        drinkIntake.timestamp = Date()
                        drinkIntake.total = 1
                        drinkIntake.volume = decimalNumFormater(stringNumber: selectedVolume) ?? 0.0
                        drinkIntake.drinkType = selectedDrinkType
                        
                        try? viewContext.save()
                         
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
