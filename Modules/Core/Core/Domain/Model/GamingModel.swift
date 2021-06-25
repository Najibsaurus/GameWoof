//
//  GamingModel.swift
//  Game
//
//  Created by Najib Abdillah on 24/06/21.
//

import Foundation

public struct GamingModel: Equatable, Identifiable {
    
    public let id: Int
    public let backgroundImage: String
    public let name: String
    public let released: String
    public let rating: Double
    
    public init(id: Int, backgroundImage: String, name:String, released:String, rating: Double ) {
        self.id = id
        self.backgroundImage = backgroundImage
        self.name = name
        self.released = released
        self.rating = rating
    }
  
}
