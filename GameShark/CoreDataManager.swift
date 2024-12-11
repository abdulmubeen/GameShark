//
//  CoreDataManager.swift
//  GameShark
//
//  Created by Abdul Mubeen Mohammed on 2024-12-10.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameShark")
        container.loadPersistentStores { (_, error) in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Failed to save context: \(error)")
            }
        }
    }
    
    func fetchAllGames() -> [GameEntity]? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<GameEntity> = GameEntity.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching games: \(error)")
            return nil
        }
    }
    
    func saveGameToCoreData(title: String, gameID: String, thumbURL: String) {
        let context = persistentContainer.viewContext
        let game = GameEntity(context: context)
        game.title = title
        game.gameID = gameID
        game.thumbURL = thumbURL
        saveContext()
    }
}
