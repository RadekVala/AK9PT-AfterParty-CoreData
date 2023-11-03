//
//  DrinkIntakeListView.swift
//  AfterParty
//
//  Created by Radek Vala on 03.11.2023.
//

import SwiftUI

struct DrinkIntakeListView: View {
    
    @Environment(DrinkIntakeList.self) var drinkList
    
    @State private var showingAddSheet = false
    
    @State var alcoholIntake: Double = 0.0
    
    @State var alcoholIntakeInTime: Double = 0.0
    
    @State var hours: Double = 1.0
    
    var body: some View {
        
        @Bindable var drinkList = drinkList
        
        NavigationView {
            VStack {
                List($drinkList.drinks, editActions: .delete){ $drinkIntake in
                    NavigationLink(destination: DrinkIntakeDetailView(drinkIntake: $drinkIntake)) {
                        HStack {
                            Text(drinkIntake.drinkType.name)
                            Spacer()
                            Text("\(drinkIntake.total) pcs")
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
                .navigationBarItems(trailing: Button(action: {
                    print("button add pressed")
                    showingAddSheet.toggle()
                }){
                    Image(systemName: "wineglass")
                })
                .onAppear {
                    alcoholIntake = totalIntake(drinkList: drinkList)
                }
        }
        .sheet(isPresented: $showingAddSheet) {
            AddDrinkIntakeView(items: drinkList, isPresented: $showingAddSheet)
        }
    }
}

#Preview {
    DrinkIntakeListView().environment(DrinkIntakeList())
}
