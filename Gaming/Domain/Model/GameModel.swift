//
//  GameModel.swift
//  Gaming
//
//  Created by Najib Abdillah on 09/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Foundation


struct GameModel: Equatable, Identifiable {
    
    let id: Int
    let backgroundImage: String
    let name: String
    let released: String
    let rating: Double
  
}


struct DetailModel: Equatable, Identifiable {
    let id: Int
    let description: String?
}
