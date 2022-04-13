//
//  NetworkLog.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 13/04/2022.
//

import Foundation

class NetworkLog: NetworkServicesInterface {
    
    let networkService: NetworkService
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getFriends(completion: @escaping (FriendsResponse?, Error?) -> ()) {
        networkService.getFriends(completion: completion)
        print("Called getFriends request")
    }
    
    func getFriendsPhotos(userID: Int?, completion: @escaping (FriendsPhotoResponse?, Error?) -> ()) {
        networkService.getFriendsPhotos(userID: userID, completion: completion)
        print("Called getFriendsPhotos request for user: \(userID)")
    }
    
    func getGroups(completion: @escaping (GroupsResponse?, Error?) -> ()) {
        networkService.getGroups(completion: completion)
        print("Called getGroups request")
    }
    
    func getNewsFeed(completion: @escaping (NewsMainResponse?, Error?) -> ()) {
        networkService.getNewsFeed(completion: completion)
        print("Called getNewsFeed request")
    }
    
    
    
    
    //static let shared = NetworkService()
}
