//
//  Photo.swift
//  Vebinar01G5
//
//  Created by HZ4ever on 14/08/2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

class FriendsPhotoResponse: Codable {
    let response: FriendsPhotoItems
}

class FriendsPhotoItems: Codable {
    let items: [UserPhoto]
    let count: Int?
}

class UserPhoto: Codable {
    let owner_id: Int
    let sizes: [Sizes]
}
