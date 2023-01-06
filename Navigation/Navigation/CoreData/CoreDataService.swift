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
          let container = NSPersistentContainer(name: "PostModel")
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
    
    func saveContext(postModel: ProfilePostModel) {
        if checkPostExists(postModel: postModel) == true {
            AlertErrorSample.shared.alert(alertTitle: "Дубль поста", alertMessage: "Такой пост уже сохранён")
        } else {
//        persistentContainer.performBackgroundTask { context in
        let post = PostEntity(context: context)
        post.author = postModel.author
        post.postDescription = postModel.postDescription
        post.image = postModel.image
        post.likes = Int64(postModel.likes)
        post.views = Int64(postModel.views)
            guard context.hasChanges else { return }
            do {
                try context.save()
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
//        }
        }
    }
    
    func checkPostExists(postModel: ProfilePostModel) -> Bool {
        let postFetch: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        postFetch.predicate = NSPredicate(format: "author == %@ AND postDescription == %@ AND image == %@", postModel.author, postModel.postDescription, postModel.image)
        var isExist = false
        do {
            let results = try persistentContainer.viewContext.fetch(postFetch) as [NSManagedObject]
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
    
    
    
    func getContext() -> [ProfilePostModel]{
        let postFetch: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        var savedPostsData: [ProfilePostModel] = []
        do {
            let savedPosts = try persistentContainer.viewContext.fetch(postFetch)
            for data in savedPosts as [NSManagedObject] {
                savedPostsData.append(.init(
                                            author: data.value(forKey: "author") as! String,
                                            postDescription: data.value(forKey: "postDescription") as! String,
                                            image: data.value(forKey: "image") as! String,
                                            likes: data.value(forKey: "likes") as! Int,
                                            views: data.value(forKey: "views") as! Int))
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
        return savedPostsData
    }
    
    func getContextByAuthor(author: String) -> [ProfilePostModel]{
        let postFetch: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        postFetch.predicate = NSPredicate(format: "author == %@", author)
        var savedPostsData: [ProfilePostModel] = []
        do {
            let savedPosts = try persistentContainer.viewContext.fetch(postFetch)
            for data in savedPosts as [NSManagedObject] {
                savedPostsData.append(.init(
                                            author: data.value(forKey: "author") as! String,
                                            postDescription: data.value(forKey: "postDescription") as! String,
                                            image: data.value(forKey: "image") as! String,
                                            likes: data.value(forKey: "likes") as! Int,
                                            views: data.value(forKey: "views") as! Int))
            }
        } catch {
            print("error \(error.localizedDescription)")
        }
        return savedPostsData
    }
    
    func deleteContext(profilePostModel: ProfilePostModel) {
        let postFetch: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        postFetch.predicate = NSPredicate(format: "author == %@ AND postDescription == %@ AND image == %@", profilePostModel.author, profilePostModel.postDescription, profilePostModel.image)
        do {
            let results = try persistentContainer.viewContext.fetch(postFetch) as [NSManagedObject]
            for data in results {
                persistentContainer.viewContext.delete(data)
            }
            try persistentContainer.viewContext.save()
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
}
