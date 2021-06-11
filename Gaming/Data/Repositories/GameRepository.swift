//
//  GameRepository.swift
//  Gaming
//
//  Created by Najib Abdillah on 08/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Foundation
import RxSwift


protocol GameRepositoryProtocol {
    
    func getRequest() -> Observable<[GameModel]>
    func getDetail(by id: String) -> Observable<DetailModel>
    func getSearch(by name: String) -> Observable<[GameModel]>
    
    func getFavoriteList() -> Observable<[GameModel]>
    func findById(id: Int) -> Bool
    func favorite(game: GameModel)
    func unFavorite(game: GameModel)
    
}


 final class GameRepository: NSObject {

  typealias GameInstance = (GameStorageDataSource, RemoteDataSource) -> GameRepository

  fileprivate let remote: RemoteDataSource
  fileprivate let local: GameStorageDataSource
    

  private init(local: GameStorageDataSource, remote: RemoteDataSource) {
    self.remote = remote
    self.local = local
        
  }

  static let sharedInstance: GameInstance = { localRepo, remoteRepo in
    return GameRepository(local: localRepo, remote: remoteRepo)
  }

    
}

extension GameRepository : GameRepositoryProtocol {
    func getFavoriteList() -> Observable<[GameModel]> {
        return local.listGameData().map { GameMapper.mapGameEntitiesToDomains(input: $0)}
    }
    
    func findById(id: Int) -> Bool {
        return local.findByID(id: id)
    }
    
    func favorite(game: GameModel) {
        local.favorite(game: GameMapper.mapGameDomainsToEntities(input: game))
    }
    
    func unFavorite(game: GameModel) {
        local.unFavorite(game: GameMapper.mapGameDomainsToEntities(input: game))
    }
    
    func unFavorite(game: GameEntity) {
        local.unFavorite(game: game)
    }
    
    func favorite(game: GameEntity) {
        local.favorite(game: game)
    }
    
    func getSearch(by name: String) -> Observable<[GameModel]> {
        return self.remote.getSearch(by: name).map { GameMapper.mapGameResponsesToDomains(input: $0) }
    }
    
    
    func getDetail(by id: String) -> Observable<DetailModel> {
        return self.remote.getDetail(by: id).map {GameMapper.mapGameDetailResponseToDomain(input: $0)}
    }
    
   
    func getRequest() -> Observable<[GameModel]> {
        return self.remote.getRequest().map { GameMapper.mapGameResponsesToDomains(input: $0) }
    }
        
    
}
