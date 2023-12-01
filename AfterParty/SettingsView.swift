//
//  SettingsView.swift
//  AfterParty
//
//  Created by Radek Vala on 01.12.2023.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var isPresented: Bool
    
    // user weight is loaded from persistent memory User Defaults
    @State var weight = UserDefaults.standard.integer(forKey: "weight")
    
    
    var body: some View {
    
        NavigationView {
            Form {
                Section(footer: Text("Enhance your alcohol intake accuracy by entering your body weight.")){
                    HStack {
                        Text("Enter your body weight:")
                        Spacer()
                        TextField("Your weight", value: $weight, format: .number)
                            .frame(width: 35)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarItems(
                trailing: Button("Save") {
                    // save event handler
                    isPresented = false
                    UserDefaults.standard.set(weight, forKey: "weight")
                })
        }
        
    }
}
