//
//  UserPhotoDB.swift
//  Vebinar01G5
//
//  Created by Anton Hodyna on 03/01/2022.
//

import Foundation
import RealmSwift

class UserPhotoDB: Object {
    @objc dynamic var owner_id = 0
    var userPhotos = List<String>()
    
    func insertOrUpdate(userPhotos: [UserPhoto]) {
        let newUserPhotoDB = UserPhotoDB()
        newUserPhotoDB.owner_id = userPhotos.first?.owner_id ?? 0
        for photo in userPhotos {
            if let lastPhoto = photo.sizes.last?.url {
                newUserPhotoDB.userPhotos.append(lastPhoto)
            }
        }
        do {
            let realm = try! Realm()
            try? realm.write{
                realm.add(newUserPhotoDB, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    override static func primaryKey() -> String? { //Ставим первичный ключ
        return "owner_id"
    }
}

