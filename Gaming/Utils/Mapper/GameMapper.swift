//
//  GameMapper.swift
//  Gaming
//
//  Created by Najib Abdillah on 09/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Foundation

final class GameMapper {
    
    static func mapGameResponsesToDomains( input gameResponses: [ResultGame]) -> [GameModel] {
        return gameResponses.map { result in
        return GameModel(id: result.id ?? 0, backgroundImage: result.backgroundImage ?? "", name: result.name ?? "", released: result.released ?? "", rating: result.rating ?? 0.0)
        }
    }

    
   
    static func mapGameResponsesToEntities( input gameResponses: [ResultGame]) -> [GameEntity] {
        return gameResponses.map { result in
          
            let newGame = GameEntity()
            newGame.id = "\(String(describing: result.id))"
            newGame.backgroundImage = result.backgroundImage ?? ""
            newGame.name = result.name ?? ""
            newGame.released = result.released ?? ""
            newGame.rating = result.rating ?? 0.0
            return newGame
        }
      }
       
      static func mapGameEntitiesToDomains(input gameEntities: [GameEntity]) -> [GameModel] {
        return gameEntities.map { result in
            return GameModel(id: Int(result.id ?? "0") ?? 0, backgroundImage: result.backgroundImage ?? "", name: result.name ?? "" , released: result.released ?? "", rating: result.rating )
        }
      }
    
    static func mapGameDomainsToEntities(input gameModel: GameModel) -> GameEntity {
        
        let new = GameEntity()
        new.id = "\(String(describing: gameModel.id))"
        new.backgroundImage = gameModel.backgroundImage
        new.name = gameModel.name
        new.released = gameModel.released
        new.rating = gameModel.rating
        
        return new
        
    }
    
    static func mapGameDomainToResponse(input gameDomain: [GameModel]) -> [ResultGame] {
        return gameDomain.map { result in
            return ResultGame(id: result.id , backgroundImage: result.backgroundImage , name: result.name , released: result.released, rating: result.rating )
        }
    }
    
    static func mapGameDetailResponseToDomain(input gameDetail: DetailCall) -> DetailModel {
            return DetailModel(id: gameDetail.id ?? 0, description: gameDetail.description ?? "")
    }
    
    static func mapGameDomainToRespinse(input gameDetail: DetailModel) -> DetailCall {
        
            return DetailCall(id: gameDetail.id, description: gameDetail.description)
        
    }
    
    
      
}
