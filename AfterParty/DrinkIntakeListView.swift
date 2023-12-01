//
//  DrinkIntakeListView.swift
//  AfterParty
//
//  Created by Radek Vala on 03.11.2023.
//

import SwiftUI

struct DrinkIntakeListView: View {
    
    //@Environment(DrinkIntakeList.self) var drinkList
    
    // Core Data persistent context
    @Environment(\.managedObjectContext) var viewContext
    
    // Fetch request for DrinkIntakeEntity
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \DrinkIntakeEntity.timestamp, ascending: false)
        ], animation: .default
    ) var items: FetchedResults<DrinkIntakeEntity>
    
    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \DrinkTypeEntity.name, ascending: true)
        ]
    ) private var drinkTypes: FetchedResults<DrinkTypeEntity>
    
    
    @State private var showingAddSheet = false
    @State private var showingSettingsSheet = false
    
    @State var alcoholIntake: Double = 0.0
    
    @State var alcoholIntakeInTime: Double = 0.0
    
    @State var hours: Double = 1.0
    
    init () {
        DataController.shared.populateInitialDataIfNeeded()
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    ForEach(items) { item in
                        NavigationLink(destination: DrinkIntakeDetailView(drinkIntake: item)) {
                            HStack {
                                Text(item.drinkType?.name ?? "Drink name not set")
                                Spacer()
                                Text("\(item.total) unit")
                            }
                        }
                    }
                }
                
                VStack {
                    Text("\(alcoholIntake, specifier: "%.2f") ‰")
                        .padding()
                    Slider(value: $hours, in: 0...48, step: 0.5)
                        .padding()
                        .onChange(of: hours) {
                            alcoholIntakeInTime = promileInTime(totalPromile: alcoholIntake, hours: hours)
                        }
                    Text("Alcohol in blood after \(hours, specifier: "%.1f") hours: ")
                    Text("\(alcoholIntakeInTime, specifier: "%.2f") ‰")
                }
                
                
            }.navigationTitle("AfterParty")
                .navigationBarItems(trailing:
                                        
                HStack {
                    Button(action: {
                        print("button settings pressed")
                        showingSettingsSheet.toggle()
                    }){
                        Image(systemName: "gearshape")
                    }
                    Button(action: {
                        print("button add pressed")
                        showingAddSheet.toggle()
                    }){
                        Image(systemName: "wineglass")
                    }
                }
                                    )
            .onAppear {
                alcoholIntake = totalIntake(drinkList: items)
                alcoholIntakeInTime = promileInTime(totalPromile: alcoholIntake, hours: hours)
            }
        }
        //opening action sheet (popover)
        .sheet(isPresented: $showingAddSheet) {
            if let firstDrink = drinkTypes.first {
                AddDrinkIntakeView(selectedDrinkType: firstDrink, isPresented: $showingAddSheet)
            }
        }
        // opening of SettingsView
        .sheet(isPresented: $showingSettingsSheet) {
            SettingsView(isPresented: $showingSettingsSheet)
        }
    }
}

/*
 #Preview {
 DrinkIntakeListView().environment(DrinkIntakeList())
 }
 */
