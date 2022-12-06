//
//  CoreDataService.swift
//  Navigation
//
//  Created by Artur Skaliy on 15.11.2022.
//

import Foundation
import CoreData


class CoreDataService {
    
    var persistentContainer: NSPersistentContainer = {
          let container = NSPersistentContainer(name: "PostModel")
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()
    
    lazy var context: NSManagedObjectContext = self.persistentContainer.viewContext
    
    func saveContext(postModel: ProfilePostModel) {
        if checkPostExists(postModel: postModel) == true {
            AlertErrorSample.shared.alert(alertTitle: "Дубль поста", alertMessage: "Такой пост уже сохранён")
        } else {
        persistentContainer.performBackgroundTask { context in
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
        }
        }
    }
    
    func checkPostExists(postModel: ProfilePostModel) -> Bool {
        let postFetch: NSFetchRequest<PostEntity> = PostEntity.fetchRequest()
        postFetch.predicate = NSPredicate(format: "author == %@", postModel.author)
        postFetch.predicate = NSPredicate(format: "postDescription == %@", postModel.postDescription)
        postFetch.predicate = NSPredicate(format: "image == %@", postModel.image)
        var isExist = false
        do {
            let results = try context.fetch(postFetch) as [NSManagedObject]
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
            let savedPosts = try context.fetch(postFetch)
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
        postFetch.predicate = NSPredicate(format: "author == %@", profilePostModel.author)
        do {
            let results = try context.fetch(postFetch) as [NSManagedObject]
            for data in results {
                context.delete(data)
            }
            try context.save()
        } catch {
            print("error \(error.localizedDescription)")
        }
    }
}
