//
//  GamingRepository.swift
//  Game
//
//  Created by Najib Abdillah on 24/06/21.
//


import Core
import RxSwift

public struct GamingRepository<RemoteDataSource: DataSource, GamingMapper: Mapper> : Repository
where
    RemoteDataSource.Request == String,
    RemoteDataSource.Response == [ResultGaming],
    GamingMapper.Response == [ResultGaming],
    GamingMapper.Entity == [GamingEntity],
    GamingMapper.Domain == [GamingModel] {
        
    public typealias Request = String
    public typealias Response = [GamingModel]
    
    private let remote: RemoteDataSource
    private let mapper: GamingMapper
    

    public init(remoteDataSource: RemoteDataSource, gamingMapper: GamingMapper){
        remote = remoteDataSource
        mapper = gamingMapper
    }
    
    
    public func execute(request: String) -> Observable<[GamingModel]> {
        let getRequest = remote.execute(request: request)
        return getRequest.map { mapper.transformResponseToDomain(response: $0)}
    }
    
}
