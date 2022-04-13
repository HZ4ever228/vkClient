//
//  NetworkLayer.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 12/08/2021.
//

import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift
import WebKit

class NetworkService: NetworkServicesInterface {
    
    private let token = Session.instance.token
    
    func getFriends(completion: @escaping (FriendsResponse?, Error?) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/friends.get"
        components.queryItems = [
            URLQueryItem(name: "fields", value: "photo_200_orig,bdate"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: token)
        ]
        
        let request = URLRequest(url: components.url!)
        debugPrint(request)
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(FriendsResponse.self, from: data)
                    completion(json, nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                debugPrint(error)
            }
        }
        dataTask.resume()
    }
    
    func getFriendsPhotos(userID: Int?, completion: @escaping (FriendsPhotoResponse?, Error?) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/photos.get"
        components.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(userID ?? 0)"),
            URLQueryItem(name: "album_id", value: "profile"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: token)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(FriendsPhotoResponse.self, from: data)
                    
                    completion(json, nil)
                } catch {
                    debugPrint("error: \(error)")
                    completion(nil, error)
                }
            }
        }
        dataTask.resume()
    }
    
    func getGroups(completion: @escaping (GroupsResponse?, Error?) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/groups.get"
        components.queryItems = [
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: token)
        ]
        
        let request = URLRequest(url: components.url!)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(GroupsResponse.self, from: data)
                    completion(json, nil)
                } catch {
                    completion(nil, error)
                }
            } else {
                debugPrint(error)
            }
        }
        dataTask.resume()
    }
    
    //MARK: - GetNewsFeed -
    
    func getNewsFeed(completion: @escaping (NewsMainResponse?, Error?) -> ()) {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = "/method/newsfeed.get"
        components.queryItems = [
            URLQueryItem(name: "filter", value: "post"),
            URLQueryItem(name: "v", value: "5.131"),
            URLQueryItem(name: "access_token", value: token)
        ]
        let request = URLRequest(url: components.url!)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let newsFeedData = data {
                do {
                    let newsFeedRespounse = try JSONDecoder().decode(NewsMainResponse.self, from: newsFeedData)
                    completion(newsFeedRespounse, nil)
                } catch let err {
                    completion(nil, err)
                }
            }
        }
        dataTask.resume()
    }
    
    //func setdTestRequest() {
    //
    //    let token = Session.instance.token
    //    guard let url = URL(string: "https://api.vk.com/method/newsfeed.get?filter=post&v=5.131&access_token=\(token)") else { return }
    //    let request = URLRequest(url: url)
    //
    //    let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
    ////            print(response)
    //        if let data = data {
    //            do {
    //
    ////                    формат хмл
    //                let json = try JSONSerialization.jsonObject(with: data)
    //                print("json: \(json)")
    //            } catch {
    //                print("error: \(error)")
    //            }
    //        }
    //
    //    }
    //
    //    dataTask.resume()
    //
    //}
}


