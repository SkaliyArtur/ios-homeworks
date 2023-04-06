//
//  CoreDataService.swift
//  Navigation
//
//  Created by Artur Skaliy on 15.11.2022.
//

import Foundation
import CoreData


class CoreDataService {
    
    
    static let coreManager = CoreDataService()
    
    var persistentContainer: NSPersistentContainer = {
          let container = NSPersistentContainer(name: "FeedModel")
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()
    
    lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    
    
    
    
//    let fetchResultController: NSFetchedResultsController<PostEntity> = {
//        let fetchRequest: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "author", ascending: false)]
//        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataService.coreManager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
//        return frc
//    }()
    
    func saveContext(feedModel: FeedsModel) {
        if checkFeedExists(feedModel: feedModel) == true {
            AlertErrorSample.shared.alert(alertTitle: NSLocalizedString("Double post", comment: ""), alertMessage: NSLocalizedString("Post already exists", comment: ""))
        } else {
//        persistentContainer.performBackgroundTask { context in
        let feed = FeedEntity(context: context)
            feed.feedsTitle = feedModel.feedsTitle
            feed.feedsText = feedModel.feedsText
            feed.feedsImage = feedModel.feedsImage
            feed.feedsDate = feedModel.feedsDate
            guard context.hasChanges else { return }
            do {
                try context.save()
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
//        }
        }
    }
    
    func checkFeedExists(feedModel: FeedsModel) -> Bool {
        let feedFetch: NSFetchRequest<FeedEntity> = FeedEntity.fetchRequest()
        feedFetch.predicate = NSPredicate(format: "feedsTitle == %@ AND feedsText == %@ AND feedsImage == %@ AND feedsDate == %@", feedModel.feedsTitle, feedModel.feedsText, feedModel.feedsImage, feedModel.feedsDate)
        var isExist = false
        do {
            let results = try persistentContainer.viewContext.fetch(feedFetch) as [NSManagedObject]
            if results.count > 0 {
                isExist = true
            } else {
                isExist = false
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
         return isExist
    }
    
    
    
    func getContext() -> [FeedsModel]{
        let feedFetch: NSFetchRequest<FeedEntity> = FeedEntity.fetchRequest()
        var savedFeedsData: [FeedsModel] = []
        do {
            let savedFeeds = try persistentContainer.viewContext.fetch(feedFetch)
            for data in savedFeeds as [NSManagedObject] {
                savedFeedsData.append(.init(feedsTitle: data.value(forKey: "feedsTitle") as! String, feedsText: data.value(forKey: "feedsText") as! String, feedsImage: data.value(forKey: "feedsImage") as! String, feedsDate: data.value(forKey: "feedsDate") as! String))
//                savedFeedsData.append(.init(feedsTitle: data.value(forKey: "author") as! String, feedsText: data.value(forKey: "postDescription") as! String, feedsImage: data.value(forKey: "image") as! String, feedsDate: data.value(forKey: "likes") as! Int, feedsCountry: data.value(forKey: "views") as! Int))
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
        return savedFeedsData
    }
    
//    func getContextByAuthor(author: String) -> [FeedsModel]{
//        let postFetch: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
//        postFetch.predicate = NSPredicate(format: "author == %@", author)
//        var savedPostsData: [FeedsModel] = []
//        do {
//            let savedPosts = try persistentContainer.viewContext.fetch(postFetch)
//            for data in savedPosts as [NSManagedObject] {
////                savedPostsData.append(.init(feedsTitle: data.value(forKey: "author") as! String, feedsText: data.value(forKey: "postDescription") as! String, feedsImage: data.value(forKey: "image") as! String, feedsDate: data.value(forKey: "likes") as! Int, feedsCountry: data.value(forKey: "views") as! Int))
//            }
//        } catch {
//            print("error \(error.localizedDescription)")
//        }
//        return savedPostsData
//    }
    
    func deleteContext(FeedsModel: FeedsModel) {
        let feedFetch: NSFetchRequest<FeedEntity> = FeedEntity.fetchRequest()
//        postFetch.predicate = NSPredicate(format: "author == %@ AND postDescription == %@ AND image == %@", profilePostModel.author, profilePostModel.postDescription, profilePostModel.image)
        do {
            let results = try persistentContainer.viewContext.fetch(feedFetch) as [NSManagedObject]
            for data in results {
                persistentContainer.viewContext.delete(data)
            }
            try persistentContainer.viewContext.save()
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
}
