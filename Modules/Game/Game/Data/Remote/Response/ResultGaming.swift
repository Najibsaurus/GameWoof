//
//  ResultGaming.swift
//  Game
//
//  Created by Najib Abdillah on 24/06/21.
//

import Foundation

public struct ResultGaming: Decodable {
    let id: Int?
    let backgroundImage: String?
    let name: String?
    let released: String?
    let rating: Double?

    private enum CodingKeys: String, CodingKey {
        case id, name, released, rating, backgroundImage = "background_image"
        
        
    }
}
