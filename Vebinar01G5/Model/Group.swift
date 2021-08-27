//
//  Group.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 28/06/2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

class GroupsResponse: Decodable {
    let response: GroupsItems
}

class GroupsItems: Decodable {
    let items: [Group]
    let count: Int?
}

class Group: RealmSwift.Object, Decodable {
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var screen_name: String
    @objc dynamic var is_closed: Int
    @objc dynamic var type: String
    @objc dynamic var photo_50: String
    @objc dynamic var photo_100: String
    @objc dynamic var photo_200: String

    override static func primaryKey() -> String? { //Ставим первичный ключ
        return "id"
    }
}

