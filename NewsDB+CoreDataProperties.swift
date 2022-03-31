//
//  NewsDB+CoreDataProperties.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 29/12/2021.
//
//

import Foundation
import CoreData


extension NewsDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsDB> {
        return NSFetchRequest<NewsDB>(entityName: "NewsDB")
    }

    @NSManaged public var attachmentPhoto: String?
    @NSManaged public var attachmentType: String?
    @NSManaged public var date: Int64
    @NSManaged public var isLiked: Int16
    @NSManaged public var likeCount: Int32
    @NSManaged public var postCreatorName: String?
    @NSManaged public var postCreatorPhoto: String?
    @NSManaged public var postFromUser: Bool
    @NSManaged public var postId: Int64
    @NSManaged public var repostCount: Int32
    @NSManaged public var sourceId: Int64
    @NSManaged public var text: String?
    @NSManaged public var type: String?
    @NSManaged public var viewCount: Int32

}

extension NewsDB : Identifiable {

}
