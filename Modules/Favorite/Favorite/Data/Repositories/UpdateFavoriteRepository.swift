//
//  UpdateFavoriteRepository.swift
//  Favorite
//
//  Created by Najib Abdillah on 24/06/21.
//

import Foundation

import Core
import RxSwift

public struct UpdateFavoriteRepository<localDataSource: LocalDataSource> : Repository
where
    localDataSource.Request == GamingEntity,
    localDataSource.Response == Bool {
    
    public typealias Request = GamingEntity
    public typealias Response = Bool
    
    private let local: localDataSource
    
    public init(localdb: localDataSource){
        local = localdb
    }
 
    public func execute(request: GamingEntity) -> Observable<Bool> {
        
        return local.updateFavorite(game: request)
        
    }

}
