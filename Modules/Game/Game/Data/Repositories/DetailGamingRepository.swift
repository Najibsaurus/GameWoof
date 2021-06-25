//
//  DetailGamingRepository.swift
//  Game
//
//  Created by Najib Abdillah on 24/06/21.
//

import Core
import RxSwift

public struct DetailGamingRepository<localDataSource: LocalDataSource, RemoteDataSource: DataSource, DetailGamingMapper: Mapper> : Repository
where

    localDataSource.Request == Any,
    localDataSource.Response == Any ,

    RemoteDataSource.Request == String,
    RemoteDataSource.Response == DetailCallGaming,
    
    DetailGamingMapper.Request == GamingModel,
    DetailGamingMapper.Entity == GamingEntity,
    DetailGamingMapper.Response == DetailCallGaming,
    DetailGamingMapper.Domain == DetailGameModel {
    
    public typealias Request = Any
    public typealias Response = Any
    
    private let remote: RemoteDataSource
    private let local: localDataSource
    private let mapper: DetailGamingMapper
    

    public init(localDataSource: localDataSource ,remoteDataSource: RemoteDataSource, gamingMapper: DetailGamingMapper){
        remote = remoteDataSource
        mapper = gamingMapper
        local = localDataSource
    }
            
    public func execute(request: Any) -> Observable<Any> {
        let url = GameUtility.unwrapAny(any: request)
        guard url is String else {
            let map = mapper.transformDomainToEntity(domain: (url as? GamingModel)! )
            return local.updateFavorite(game: map)
        }
        let urlRequest = url as? String ?? ""
        guard urlRequest.contains("https") else {
            return local.checkFavorite(game: urlRequest)
        }
        let getRequest = remote.execute(request: urlRequest)
        return getRequest.map { mapper.transformResponseToDomain(response: $0)}
    }
    
 
}
