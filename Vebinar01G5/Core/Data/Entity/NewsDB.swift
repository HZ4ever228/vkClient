//
//  NewsDB.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 29/12/2021.
//

import Foundation
import CoreData

class NewsDB: NSManagedObject {
    
    static func fetch(newsId: Int64, in context: NSManagedObjectContext) -> NewsDB? {
        let request: NSFetchRequest<NewsDB> = NewsDB.fetchRequest()
        request.predicate = NSPredicate(format: "postId = %@", NSNumber(value: newsId))
        request.fetchBatchSize = 1
        let result = try? context.fetch(request)
        if let newsDB = result?[0] {
            return newsDB
        } else { return nil }
    }
    
    static func insertOrUpdate(matching newsData: NewsFeedResponse, in context: NSManagedObjectContext) throws {
        
        let request: NSFetchRequest<NewsDB> = NewsDB.fetchRequest()
        if let items = newsData.items {
            for item in items {
                guard let uid = item.post_id else { return }
                
                //            let formatterFrom = DateFormatter()
                //            formatterFrom.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
                request.predicate = NSPredicate(format: "postId = %@", NSNumber(value: uid))
                do {
                    let matches = try context.fetch(request)
                    if matches.count > 0 {
                        
                        matches[0].postId = item.post_id ?? 0
                        matches[0].type = item.type ?? ""
                        matches[0].sourceId = item.source_id ?? 0
                        if (item.source_id ?? 0) > 0 {
                            matches[0].postFromUser = true
                        } else {
                            matches[0].postFromUser = false
                        }
                        
                        switch matches[0].postFromUser {
                        case true:
                            if let userID = item.source_id, let user = newsData.profiles?.first(where: {$0.id ?? 0 == userID}) {
                                matches[0].postCreatorName = (user.first_name ?? "") + (user.last_name ?? "")
                                matches[0].postCreatorPhoto = user.photo_100
                            }
                        case false:
                            if let groupID = item.source_id, let group = newsData.groups?.first(where: {$0.id == groupID}) {
                                matches[0].postCreatorName = group.name
                                matches[0].postCreatorPhoto = group.photo_100
                            }
                        }
                        matches[0].date = item.date ?? 0
                        matches[0].text = item.text
                        if let attachments = item.attachments {
                            var postPhotos = ""
                            for attachment in attachments {
                                if attachment.type == "photo", let photoString = attachment.photo?.sizes?.last?.url {
                                    postPhotos += photoString
                                    postPhotos += " , "
                                }
                            }
                            matches[0].attachmentPhoto = postPhotos
                        }
                        matches[0].likeCount = item.likes?.count ?? 0
                        matches[0].isLiked = item.likes?.user_likes ?? 0
                        matches[0].repostCount = item.reposts?.count ?? 0
                        matches[0].viewCount = item.views?.count ?? 0
                        
                    } else {
                        let newsDB = NewsDB(context: context)
                        newsDB.postId = item.post_id ?? 0
                        newsDB.type = item.type ?? ""
                        newsDB.sourceId = item.source_id ?? 0
                        if (item.source_id ?? 0) > 0 {
                            newsDB.postFromUser = true
                        } else {
                            newsDB.postFromUser = false
                        }
                        
                        switch newsDB.postFromUser {
                        case true:
                            if let userID = item.source_id, let user = newsData.profiles?.first(where: {$0.id ?? 0 == userID}) {
                                newsDB.postCreatorName = (user.first_name ?? "") + (user.last_name ?? "")
                                newsDB.postCreatorPhoto = user.photo_100
                            }
                        case false:
                            if let groupID = item.source_id, let group = newsData.groups?.first(where: {$0.id == groupID}) {
                                newsDB.postCreatorName = group.name
                                newsDB.postCreatorPhoto = group.photo_100
                            }
                        }
                        newsDB.date = item.date ?? 0
                        newsDB.text = item.text
                        if let attachments = item.attachments {
                            var postPhotos = ""
                            for attachment in attachments {
                                if attachment.type == "photo", let photoString = attachment.photo?.sizes?.last?.url {
                                    postPhotos += photoString
                                    postPhotos += " , "
                                }
                            }
                            newsDB.attachmentPhoto = postPhotos
                        }
                        newsDB.likeCount = item.likes?.count ?? 0
                        newsDB.isLiked = item.likes?.user_likes ?? 0
                        newsDB.repostCount = item.reposts?.count ?? 0
                        newsDB.viewCount = item.views?.count ?? 0
                    }
                } catch {
                    throw error
                }
            }
        }
    }
    
    static func processingResponse(dataStack: DATAStack, newsData: NewsMainResponse, completion: @escaping () -> Void) {
        
        dataStack.performBackgroundTask { context in
            try? NewsDB.insertOrUpdate(matching: newsData.response, in: context)
            try? context.save()
            dataStack.viewContext.perform {
                if Thread.isMainThread {
                    completion()
                }
            }
        }
    }
}
