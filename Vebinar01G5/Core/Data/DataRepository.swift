//
//  DataRepository.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 29/12/2021.
//

import Foundation
import CoreData
import RealmSwift
import UIKit

class DataRepository {
    
    public static let shared = DataRepository()
    
    private let realm = try! Realm()
    private let networkLog = NetworkLog(networkService: NetworkService())
    
    func getFriends(completion: @escaping (Error?, [User]?) -> (Void)) {
        networkLog.getFriends(completion: { friendsData, error in
            if error == nil, let items = friendsData?.response.items {
                DispatchQueue.main.async {
                    do {
                        try? self.realm.write{
                            self.realm.add(items, update: .modified)
                        }
                        let users = self.realm.objects(User.self)
                        completion(error, Array(users))
                    }
                }
            } else {
                completion(error, nil)
            }
        })
    }
    
    func getFriendsPhotos(userID: Int, completion: @escaping (Error?, UserPhotoDB?) -> (Void)) {
        networkLog.getFriendsPhotos(userID: userID, completion: { friendPhotoData, error in
            if error == nil, let items = friendPhotoData?.response.items {
                DispatchQueue.main.async {
                    do {
                        let userPhoto = UserPhotoDB()
                        userPhoto.insertOrUpdate(userPhotos: items)
                        let userPhotos = self.realm.objects(UserPhotoDB.self)
                        completion(error, userPhotos.first(where: {$0.owner_id == userID}))
                        }
                    }
            } else {
                completion(error, nil)
            }
        })
    }
    
    func getGroups(completion: @escaping (Error?, [Group]?) -> (Void)) {
        networkLog.getGroups(completion: { groupsData, error in
            if error == nil, let items = groupsData?.response.items {
                DispatchQueue.main.async {
                    do {
                        try? self.realm.write{
                            self.realm.add(items, update: .modified)
                        }
                        let groups = self.realm.objects(Group.self)
                        completion(error, Array(groups))
                    }
                }
            } else {
                completion(error, nil)
            }
        })
    }
    
    func getNews(completion: @escaping (Error?, [NewsDB]?) -> (Void)) {
        networkLog.getNewsFeed() { newsData, error in
            if error == nil, let response = newsData?.response {
                DispatchQueue.main.async {
                    do {
                        let news = NewsDB()
                        news.insertOrUpdate(response: response)
                        let newsFeed = self.realm.objects(NewsDB.self)
                        completion(error, Array(newsFeed))
                    }
                }
            } else {
                completion(error, nil)
            }
        }
    }
}
