//
//  Photo.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 14/08/2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

class FriendsPhotoResponse: Decodable {
    let response: FriendsPhotoItems
}

class FriendsPhotoItems: Decodable {
    let items: [UserPhoto]
    let count: Int?
}

class UserPhoto: RealmSwift.Object, Decodable {
   @objc dynamic var owner_id: Int
  @objc dynamic var photo_604: String
    override static func primaryKey() -> String? { //Ставим первичный ключ
        return "photo_604"
    }
   }
