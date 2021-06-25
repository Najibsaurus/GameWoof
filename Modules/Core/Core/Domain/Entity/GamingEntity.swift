//
//  GamingEntity.swift
//  Core
//
//  Created by Najib Abdillah on 24/06/21.
//

import RealmSwift

public class GamingEntity: Object, Codable {
    
    @objc public dynamic var id: String?
    @objc public dynamic var backgroundImage: String?
    @objc public dynamic var name: String?
    @objc public dynamic var released: String?
    @objc public dynamic var rating: Double = 0.0

    public override init() {}

    public override static func primaryKey() -> String? {
        return "id"
    }
}
