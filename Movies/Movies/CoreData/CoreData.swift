//
//  CoreData.swift
//  Movies
//
//  Created by sambath on 11/05/23.
//

import Foundation
import UIKit
import CoreData

class CoreData {
    
    static let sharedInstance = CoreData()
    private init(){}
    
    private let continer: NSPersistentContainer? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    
    private let fetchRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    
    func saveDataOf(movies:[Movie]) {
        
        self.continer?.performBackgroundTask{ [weak self] (context) in
            self?.deleteObjectsfromCoreData(context: context)
            self?.saveDataToCoreData(movies: movies, context: context)
        }
    }
    
  private func deleteObjectsfromCoreData(context: NSManagedObjectContext) {
        do {
            let objects = try context.fetch(fetchRequest)
            
            _ = objects.map({context.delete($0)})
            
            try context.save()
        } catch {
            print("Deleting Error: \(error)")
        }
    }
    
    private func saveDataToCoreData(movies:[Movie], context: NSManagedObjectContext) {
        context.perform {
            for movie in movies {
                let movieEntity = MovieEntity(context: context)
                movieEntity.title = movie.title
                movieEntity.year = movie.year
                guard let rate = movie.rate else {return}
                movieEntity.rate = String(rate)
                movieEntity.posterImage = movie.posterImage
                movieEntity.backdropImage = movie.backdropImage
                movieEntity.overview = movie.overview
            }
            do {
                try context.save()
            } catch {
                fatalError("Failure to save context: \(error)")
            }
        }
    }
}
