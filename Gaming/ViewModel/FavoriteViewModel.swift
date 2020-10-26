//
//  FavoriteViewModel.swift
//  Gaming
//
//  Created by Najib on 17/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class FavoriteViewModel : NSObject {
 
    
    let nameKey = "name"
    let idPredicate = "id = %d"
    let context: NSManagedObjectContext
    private(set) var gaming: [Gaming] = []
    var delegate: FavoriteViewModelDelegate?
    let request: NSFetchRequest<Gaming> = Gaming.fetchRequest()
    var resultsController : NSFetchedResultsController<Gaming>?
    
    
    override init() {
        context = ((UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext)!
        
    }
    
    func addToFavorite(game: Results)  {
        do {
            let newData = Gaming(id: game.id ?? 0, background_image: game.backgroundImage, name: game.name ?? "", released: game.released ?? "0", rating: game.rating ?? 0.0, context: context)
                gaming.append(newData)
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    
    func findById(id: Int) -> Bool {
         request.predicate = NSPredicate(format: idPredicate, id)
         var entitiesCount = 0
         do {
             entitiesCount = try context.count(for: request)
         }
         catch {
             print(error)
         }
         return entitiesCount > 0
    }
    
    func unFavorite(id: Int)  {
        request.predicate = NSPredicate(format: idPredicate, id)
        do {
            let objects = try context.fetch(request)
            for object in objects {
                context.delete(object)
            }
            try context.save()
        } catch {
            print(error)
        }
    }
    
    
    func fetchData(){
        if resultsController == nil {
            let sort = NSSortDescriptor(key: nameKey, ascending: true)
            request.sortDescriptors = [sort]
            resultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            resultsController?.delegate = self
            do {
                try resultsController?.performFetch()
                self.delegate?.completedFetchFavorite()                
            } catch {
                print(error)
            }
            
        }
    }
}

extension FavoriteViewModel : NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        self.delegate?.fetchDataDelegate()
    }
}
 
protocol FavoriteViewModelDelegate {
    func completedFetchFavorite()
    func fetchDataDelegate()
}


