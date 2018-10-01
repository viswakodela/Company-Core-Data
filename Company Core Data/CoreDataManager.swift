//
//  CoreDataManager.swift
//  Company Core Data
//
//  Created by Viswa Kodela on 9/22/18.
//  Copyright © 2018 Viswa Kodela. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager() // A Singleton will be alive as long as the application is running
    
    let persistanceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CompanyDataModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                print("Failed to load the persistance Store: \(error)")
            }
        }
        return container
    }()
    
    func createEmployee(name: String) -> Error? {
        let context = CoreDataManager.shared.persistanceContainer.viewContext
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context)
        employee.setValue(name, forKey: "name")
        
        do {
            try context.save()
            return nil
        } catch {
            print(error)
            return error
        }
    }
    
}
