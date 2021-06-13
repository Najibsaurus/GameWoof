//
//  GameEntity.swift
//  Gaming
//
//  Created by Najib Abdillah on 08/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers final class GameEntity: Object, Codable {
    
    dynamic var id: String?
    dynamic var backgroundImage: String?
    dynamic var name: String?
    dynamic var released: String?
    dynamic var rating: Double?

    override class func primaryKey() -> String? {
        return "id"
    }
}
