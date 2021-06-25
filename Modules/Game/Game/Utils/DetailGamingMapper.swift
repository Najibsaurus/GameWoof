//
//  DetailGamingMapper.swift
//  Game
//
//  Created by Najib Abdillah on 24/06/21.
//

import Foundation
import Core


public struct DetailGamingMapper : Mapper  {


    
    public typealias Request = GamingModel
    
    public typealias Response = DetailCallGaming
    
    public typealias Entity = GamingEntity
    
    public typealias Domain = DetailGameModel
    
    
    
    public init() {}
    
    public func transformResponseToDomain(response: DetailCallGaming) -> DetailGameModel {
        
        return DetailGameModel(id: response.id ?? 0, description: response.description ?? "")
    }

    public func transformDomainToEntity(domain: GamingModel) -> GamingEntity {
        let newEntitiy = GamingEntity()
        newEntitiy.id = "\(String(describing: domain.id))"
        newEntitiy.backgroundImage = domain.backgroundImage
        newEntitiy.name = domain.name
        newEntitiy.rating = domain.rating 
        newEntitiy.released = domain.released
        
        return newEntitiy
    }
  
    public func transformEntityToDomain(entity: GamingEntity) -> DetailGameModel {
        fatalError()
    }
    public func transformResponseToEntity(request: GamingModel?, response: DetailCallGaming) -> GamingEntity {
        fatalError()
    }
    

    
    
    
}
