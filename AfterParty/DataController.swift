//
//  DataController.swift
//  AfterParty
//
//  Created by Radek Vala on 01.12.2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    
    // shared singleton of DataController class (global point for access)
    static let shared = DataController()
    
    // select Core Data model file
    let container = NSPersistentContainer(name: "DataModel")
    
    init() {
        container.loadPersistentStores {
            storeDescription, error in
            
            if let error = error {
                fatalError("Error loading Core Data model: \(error.localizedDescription)")
            }
        }
    }
}

extension DataController {
    
    func populateInitialDataIfNeeded() {
        // request for a drink type
        let fetchRequest: NSFetchRequest<DrinkTypeEntity> = DrinkTypeEntity.fetchRequest()
        
        do {
            let count = try container.viewContext.count(for: fetchRequest)
            guard count == 0 else { return } // Data is already populated
            
            // Beer 10
            let beer10 = DrinkTypeEntity(context: container.viewContext)
            beer10.id = UUID()
            beer10.name = "Beer 10°"
            beer10.alcoholVolume = 4.0
            
            // Beer 12
            let beer12 = DrinkTypeEntity(context: container.viewContext)
            beer12.id = UUID()
            beer12.name = "Beer 12°"
            beer12.alcoholVolume = 5.0
            
            // Wine
                        let wine = DrinkTypeEntity(context: container.viewContext)
                        wine.id = UUID()
                        wine.name = "Wine"
                        wine.alcoholVolume = 12.0
                        
                        // Slivovitz
                        let slivovitz = DrinkTypeEntity(context: container.viewContext)
                        slivovitz.id = UUID()
                        slivovitz.name = "Slivovitz"
                        slivovitz.alcoholVolume = 50.0
                        
                        
                        
                        // Insert first drink intake here
                        let newItem = DrinkIntakeEntity(context: container.viewContext)
                        newItem.id = UUID()
                        newItem.total = 1
                        newItem.volume = 0.5
                        newItem.drinkType = slivovitz
                        
                        try container.viewContext.save()
                        
                    } catch {
                        fatalError("Error checking or populating initial data: \(error)")
                    }
                }
            }
