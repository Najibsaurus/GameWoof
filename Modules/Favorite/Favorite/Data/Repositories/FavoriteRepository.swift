//
//  FavoriteRepository.swift
//  Favorite
//
//  Created by Najib Abdillah on 24/06/21.
//

import Core
import RxSwift

public struct FavoriteRepository<localDataSource: LocalDataSource, GamingMapper: Mapper> : Repository
where
    localDataSource.Request == Any,
    localDataSource.Response == [GamingEntity],
    
    GamingMapper.Entity == [GamingEntity],
    GamingMapper.Domain == [GamingModel] {
   

    public typealias Request = Any
    public typealias Response = [GamingModel]
    
    private let local: localDataSource
    private let mapper: GamingMapper
    
    public init(localdb: localDataSource, gamingMapper: GamingMapper){
        local = localdb
        mapper = gamingMapper
    }
 
    public func execute(request: Any) -> Observable<[GamingModel]> {
        let getRequest = local.listGameData()
        return getRequest.map { mapper.transformEntityToDomain(entity: $0) }
    }
}
