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

class NetworkService {
    var friendViewController = FriendsViewController()
    //MARK: -saveUsersData
   
    func saveUsersData (_ users: [User]) {
            let realm = try! Realm()
            try! realm.write{
                realm.add(users, update: .modified)
            }
    }

    //MARK: -friendsRequest

    func friendsRequst(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "https://api.vk.com/method/friends.get?fields=photo_200_orig,bdate&v=5.52&access_token=\(Session.instance.token)") else { return }

        let request = URLRequest(url: url)

            let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let json = try JSONDecoder().decode(FriendsResponse.self, from: data)
                            self.saveUsersData(json.response.items)
                    } catch {
                        completion(.failure(error))
                        print(error)
                    }
                }
            }
            dataTask.resume()
        }

    //MARK: -saveGroupsData

    func saveGroupsData (_ groups: [Group]) {
        do {
            let realmGroup = try Realm()
            try! realmGroup.write{
                realmGroup.add(groups, update: .modified)
            }
        } catch {
            print(error)
        }
    }

    //MARK: -groupsRequest

    func groupsRequest(completion: @escaping (Result<[Group], Error>) -> Void) {

        guard let url = URL(string: "https://api.vk.com/method/groups.get?extended=1&v=5.52&access_token=\(Session.instance.token)") else { return }

        let request = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in

            if let data = data {
                do {
                    let json = try JSONDecoder().decode(GroupsResponse.self, from: data)
                    self.saveGroupsData(json.response.items)
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }

    //MARK: -saveFriendsPhotoData

    func saveFriendsPhotoData (userPhotos: [UserPhoto]) {
        do {
            let realm = try Realm()
            try! realm.write{
                realm.add(userPhotos, update: .modified)
            }
        } catch {
            print(error)
        }
    }

    //MARK:- friendsPhotoRequst
    func friendsPhotoRequst(userID: Int?, completion: @escaping (Result<[UserPhoto], Error>) -> Void) {

        guard let url = URL(string: "https://api.vk.com/method/photos.get?owner_id=\(userID ?? 0)&album_id=profile&v=5.52&access_token=\(Session.instance.token)") else { return }

        let request = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(FriendsPhotoResponse.self, from: data)
                    self.saveFriendsPhotoData(userPhotos: json.response.items)
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()

    }

}
