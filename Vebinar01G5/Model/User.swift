//
//  User.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 28/06/2021.
//
import RealmSwift
import UIKit
import SwiftyJSON

class FriendsResponse: Decodable {
    let response: FriendsItems
}

class FriendsItems: Decodable {
    let items: [User]
    let count: Int
}

class User: RealmSwift.Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var first_name: String
    @objc dynamic var last_name: String
    let photo_100: String?
    @objc dynamic var photo_200_orig: String

    override static func primaryKey() -> String? { //Ставим первичный ключ
        return "id"
    }
}


