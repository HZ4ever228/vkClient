//
//  NewsDB.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 03/01/2022.
//

import Foundation
import RealmSwift

class NewsDB: Object {
    @objc dynamic var post_id: Int64 = 0
    @objc dynamic var source_id: Int64 = 0
    @objc dynamic var author = ""
    @objc dynamic var authorImage = ""
    @objc dynamic var date: Int64 = 0
    @objc dynamic var text = ""
    @objc dynamic var commentsCount: Int32 = 0
    @objc dynamic var likesCount: Int32 = 0
    @objc dynamic var repostsCount: Int32 = 0
    @objc dynamic var viewsCount: Int32 = 0
    @objc dynamic var isLiked = false
    var newsPhotos = List<String>()
    
    func insertOrUpdate(response: NewsFeedResponse) {
        if let items = response.items, let groups = response.groups, let profiles = response.profiles {
            let itemGroup = DispatchGroup()
            
            for item in items {
                DispatchQueue.global().async(group: itemGroup) {
                    let newNewsDB = NewsDB()
                    
                    newNewsDB.post_id = item.post_id ?? 0
                    newNewsDB.source_id = item.source_id ?? 0
                    if (item.source_id ?? 0) > 0, let userPofile = profiles.first(where: {$0.id ?? 0 == (item.source_id ?? 0)}) {
                        newNewsDB.author = (userPofile.first_name ?? "") + " " + (userPofile.last_name ?? "")
                        newNewsDB.authorImage = userPofile.photo_100 ?? ""
                    } else if (item.source_id ?? 0) < 0, let groupProfile = groups.first(where: {$0.id == -(item.source_id ?? 0)}) {
                        newNewsDB.author = groupProfile.name
                        newNewsDB.authorImage = groupProfile.photo_100
                    }
                    
                    newNewsDB.date = item.date ?? 0
                    newNewsDB.text = item.text ?? ""
                    newNewsDB.commentsCount = item.comments?.count ?? 0
                    newNewsDB.likesCount = item.likes?.count ?? 0
                    newNewsDB.repostsCount = item.reposts?.count ?? 0
                    newNewsDB.viewsCount = item.views?.count ?? 0
                    newNewsDB.isLiked = (item.likes?.user_likes ?? 0) > 0
                    
                    if let atachments = item.attachments {
                        for atachment in atachments {
                            if let lastPhoto = atachment.photo?.sizes?.last?.url {
                                newNewsDB.newsPhotos.append(lastPhoto)
                            }
                        }
                    }
                    do {
                        let realm = try! Realm()
                        try? realm.write{
                            realm.add(newNewsDB, update: .modified)
                        }
                    } catch {
                        print(error)
                    }
                }
            }
        }
        
    }
    
    override static func primaryKey() -> String? { //Ставим первичный ключ
        return "post_id"
    }
}
