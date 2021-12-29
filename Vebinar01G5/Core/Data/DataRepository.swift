//
//  DataRepository.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 29/12/2021.
//

import Foundation
import CoreData
import RealmSwift

class DataRepository {
    
    public static let shared = DataRepository()
    
    private(set) var dataStack: DATAStack?
    
    
    func getNews(completion: @escaping (Error?) -> ()) -> NSFetchedResultsController<NewsDB>? {
        
        guard let dataStack = self.dataStack else { return nil }
      //  if RateLimiters.NEWS.shouldFetch() {
        NetworkService.shared.getNewsFeed(completion: {
            data, error in
            if error == nil, let data = data {
                NewsDB.processingResponse(dataStack: dataStack, newsData: data) {
                    completion(error)
                }
            }
        })
        let newsRequest: NSFetchRequest<NewsDB> = NewsDB.fetchRequest()
        var andPredicate = [NSPredicate]()
        newsRequest.sortDescriptors = [NSSortDescriptor(key: "postId", ascending: false)]
        newsRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: andPredicate)
        let fetchedResultsController = NSFetchedResultsController<NewsDB>(
                        fetchRequest: newsRequest,
                        managedObjectContext: dataStack.viewContext,
                        sectionNameKeyPath: nil,
                        cacheName: nil)
        return fetchedResultsController
    }
    
}
