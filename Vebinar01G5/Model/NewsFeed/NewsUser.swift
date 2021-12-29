//
//  NewsUser.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 29/12/2021.
//

import Foundation

struct Profiles : Codable {
    let id : Int?
    let first_name : String?
    let last_name : String?
    let can_access_closed : Bool?
    let is_closed : Bool?
    let sex : Int?
    let screen_name : String?
    let photo_50 : String?
    let photo_100 : String?
    let online_info : Online_info?
    let online : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case first_name = "first_name"
        case last_name = "last_name"
        case can_access_closed = "can_access_closed"
        case is_closed = "is_closed"
        case sex = "sex"
        case screen_name = "screen_name"
        case photo_50 = "photo_50"
        case photo_100 = "photo_100"
        case online_info = "online_info"
        case online = "online"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        can_access_closed = try values.decodeIfPresent(Bool.self, forKey: .can_access_closed)
        is_closed = try values.decodeIfPresent(Bool.self, forKey: .is_closed)
        sex = try values.decodeIfPresent(Int.self, forKey: .sex)
        screen_name = try values.decodeIfPresent(String.self, forKey: .screen_name)
        photo_50 = try values.decodeIfPresent(String.self, forKey: .photo_50)
        photo_100 = try values.decodeIfPresent(String.self, forKey: .photo_100)
        online_info = try values.decodeIfPresent(Online_info.self, forKey: .online_info)
        online = try values.decodeIfPresent(Int.self, forKey: .online)
    }

}

struct Online_info : Codable {
    let visible : Bool?
    let is_online : Bool?
    let is_mobile : Bool?

    enum CodingKeys: String, CodingKey {

        case visible = "visible"
        case is_online = "is_online"
        case is_mobile = "is_mobile"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        visible = try values.decodeIfPresent(Bool.self, forKey: .visible)
        is_online = try values.decodeIfPresent(Bool.self, forKey: .is_online)
        is_mobile = try values.decodeIfPresent(Bool.self, forKey: .is_mobile)
    }

}
