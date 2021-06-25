//
//  GameMapper.swift
//  Game
//
//  Created by Najib Abdillah on 24/06/21.
//

import Foundation
import Core


public struct GamingMapper : Mapper {
  
    public typealias Request = Any
    
    public typealias Response = [ResultGaming]
    
    public typealias Entity = [GamingEntity]
    
    public typealias Domain = [GamingModel]
    
    
    
    public init() {}
    
 
    public func transformResponseToEntity(request: Any?, response: [ResultGaming]) -> [GamingEntity] {
        return response.map { result in
            let newGame = GamingEntity()
            
            newGame.id = "\(String(describing: result.id))"
            newGame.backgroundImage = result.backgroundImage ?? ""
            newGame.name = result.name ?? ""
            newGame.released = result.released ?? ""
            newGame.rating = result.rating ?? 0.0
            
            return newGame
        }
    }
    
    public func transformEntityToDomain(entity: [GamingEntity]) -> [GamingModel] {
        return entity.map { result in
    
            return GamingModel(id: Int(result.id ?? "0") ?? 0, backgroundImage: result.backgroundImage ?? "", name: result.name ?? "" , released: result.released ?? "", rating: result.rating ) }
    
    }
    
    public func transformResponseToDomain(response: [ResultGaming]) -> [GamingModel] {
        return response.map { result in

            let newGame = GamingModel(
                id: result.id ?? 0, backgroundImage: result.backgroundImage ?? "", name: result.name ?? "", released: result.released ?? "", rating: result.rating ?? 0.0)
            
            return newGame
            
        }
    }
    
    public func transformDomainToEntity(domain: [GamingModel]) -> [GamingEntity] {
        fatalError()
    }
    
    public func transformDomainToEntity(domain: Any) -> [GamingEntity] {
        fatalError()
    }
    
}
