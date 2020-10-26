//
//  Results.swift
//  Gaming
//
//  Created by Najib on 13/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import Foundation


struct Results: Decodable {
    let id: Int?
    let backgroundImage: String?
    let name: String?
    let released: String?
    let rating: Double?

    private enum CodingKeys: String, CodingKey {
        case id, name, released, rating, backgroundImage = "background_image"
        
        
    }
}

