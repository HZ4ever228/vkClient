//
//  Response.swift.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 29/12/2021.
//

import Foundation
import RealmSwift

struct NewsMainResponse: Codable {
    let response: NewsFeedResponse
}

struct NewsFeedResponse : Codable {
    let items : [Items]?
    let profiles : [Profiles]?
    let groups : [Group]?
    let next_from : String?

    enum CodingKeys: String, CodingKey {

        case items = "items"
        case profiles = "profiles"
        case groups = "groups"
        case next_from = "next_from"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        items = try values.decodeIfPresent([Items].self, forKey: .items)
        profiles = try values.decodeIfPresent([Profiles].self, forKey: .profiles)
        groups = try values.decodeIfPresent([Group].self, forKey: .groups)
        next_from = try values.decodeIfPresent(String.self, forKey: .next_from)
    }

}

struct Items : Codable {
    let source_id : Int64?
    let date : Int64?
    let can_doubt_category : Bool?
    let can_set_category : Bool?
    let post_type : String?
    let text : String?
    let marked_as_ads : Int?
    let attachments : [Attachments]?
    let comments : Comments?
    let likes : Likes?
    let reposts : Reposts?
    let views : Views?
    let is_favorite : Bool?
    let donut : Donut?
    let short_text_rate : Double?
    let post_id : Int64?
    let type : String?

    enum CodingKeys: String, CodingKey {

        case source_id = "source_id"
        case date = "date"
        case can_doubt_category = "can_doubt_category"
        case can_set_category = "can_set_category"
        case post_type = "post_type"
        case text = "text"
        case marked_as_ads = "marked_as_ads"
        case attachments = "attachments"
        case comments = "comments"
        case likes = "likes"
        case reposts = "reposts"
        case views = "views"
        case is_favorite = "is_favorite"
        case donut = "donut"
        case short_text_rate = "short_text_rate"
        case post_id = "post_id"
        case type = "type"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        source_id = try values.decodeIfPresent(Int64.self, forKey: .source_id)
        date = try values.decodeIfPresent(Int64.self, forKey: .date)
        can_doubt_category = try values.decodeIfPresent(Bool.self, forKey: .can_doubt_category)
        can_set_category = try values.decodeIfPresent(Bool.self, forKey: .can_set_category)
        post_type = try values.decodeIfPresent(String.self, forKey: .post_type)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        marked_as_ads = try values.decodeIfPresent(Int.self, forKey: .marked_as_ads)
        attachments = try values.decodeIfPresent([Attachments].self, forKey: .attachments)
        comments = try values.decodeIfPresent(Comments.self, forKey: .comments)
        likes = try values.decodeIfPresent(Likes.self, forKey: .likes)
        reposts = try values.decodeIfPresent(Reposts.self, forKey: .reposts)
        views = try values.decodeIfPresent(Views.self, forKey: .views)
        is_favorite = try values.decodeIfPresent(Bool.self, forKey: .is_favorite)
        donut = try values.decodeIfPresent(Donut.self, forKey: .donut)
        short_text_rate = try values.decodeIfPresent(Double.self, forKey: .short_text_rate)
        post_id = try values.decodeIfPresent(Int64.self, forKey: .post_id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
    }

}

struct Attachments : Codable {
    let type : String?
    let photo : Photo?

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case photo = "photo"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        photo = try values.decodeIfPresent(Photo.self, forKey: .photo)
    }

}

struct Comments : Codable {
    let count : Int32?

    enum CodingKeys: String, CodingKey {

        case count = "count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int32.self, forKey: .count)
    }

}

struct Likes : Codable {
    let can_like : Int?
    let count : Int32?
    let user_likes : Int16?

    enum CodingKeys: String, CodingKey {

        case can_like = "can_like"
        case count = "count"
        case user_likes = "user_likes"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        can_like = try values.decodeIfPresent(Int.self, forKey: .can_like)
        count = try values.decodeIfPresent(Int32.self, forKey: .count)
        user_likes = try values.decodeIfPresent(Int16.self, forKey: .user_likes)
    }

}

struct Reposts : Codable {
    let count : Int32?

    enum CodingKeys: String, CodingKey {

        case count = "count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int32.self, forKey: .count)
    }

}

struct Views : Codable {
    let count : Int32?

    enum CodingKeys: String, CodingKey {

        case count = "count"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int32.self, forKey: .count)
    }

}

struct Donut : Codable {
    let is_donut : Bool?

    enum CodingKeys: String, CodingKey {

        case is_donut = "is_donut"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        is_donut = try values.decodeIfPresent(Bool.self, forKey: .is_donut)
    }

}
