//
//  DetailGameModel.swift
//  Game
//
//  Created by Najib Abdillah on 24/06/21.
//

import Foundation


public struct DetailGameModel: Equatable, Identifiable {

    public let id: Int?
    public let description: String?
    
    public init(id : Int, description: String) {
        self.id = id
        self.description = description
    }
    
}
