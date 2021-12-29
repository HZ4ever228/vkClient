//
//  Photo.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 29/12/2021.
//

import Foundation
import RealmSwift

struct Photo : Codable {
    let album_id : Int?
    let date : Int?
    let id : Int?
    let owner_id : Int?
    let access_key : String?
    let post_id : Int?
    let sizes : [Sizes]?
    let text : String?
    let user_id : Int?
    let has_tags : Bool?

    enum CodingKeys: String, CodingKey {

        case album_id = "album_id"
        case date = "date"
        case id = "id"
        case owner_id = "owner_id"
        case access_key = "access_key"
        case post_id = "post_id"
        case sizes = "sizes"
        case text = "text"
        case user_id = "user_id"
        case has_tags = "has_tags"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        album_id = try values.decodeIfPresent(Int.self, forKey: .album_id)
        date = try values.decodeIfPresent(Int.self, forKey: .date)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        owner_id = try values.decodeIfPresent(Int.self, forKey: .owner_id)
        access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
        post_id = try values.decodeIfPresent(Int.self, forKey: .post_id)
        sizes = try values.decodeIfPresent([Sizes].self, forKey: .sizes)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        has_tags = try values.decodeIfPresent(Bool.self, forKey: .has_tags)
    }

}

struct Sizes : Codable {
    let height : Int?
    let url : String?
    let type : String?
    let width : Int?

    enum CodingKeys: String, CodingKey {

        case height = "height"
        case url = "url"
        case type = "type"
        case width = "width"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
    }

}


