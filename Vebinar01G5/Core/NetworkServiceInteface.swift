//
//  NetworkServiceInteface.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 13/04/2022.
//

import Foundation

protocol NetworkServicesInterface {
    func getFriends(completion: @escaping (FriendsResponse?, Error?) -> ())
    func getFriendsPhotos(userID: Int?, completion: @escaping (FriendsPhotoResponse?, Error?) -> ())
    func getGroups(completion: @escaping (GroupsResponse?, Error?) -> ())
    func getNewsFeed(completion: @escaping (NewsMainResponse?, Error?) -> ())
}
