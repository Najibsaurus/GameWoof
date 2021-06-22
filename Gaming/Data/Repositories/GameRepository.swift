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
    func findByIdGame(id: Int) -> Observable<Bool>
    func updateFavorite(game: GameModel) -> Observable<Bool>
}


 final class GameRepository: NSObject {

  private var remote: RemoteDataSource
  private var local: GameStorageDataSource
    

  init(local: GameStorageDataSource, remote: RemoteDataSource) {
    self.remote = remote
    self.local = local
  }

    
}

extension GameRepository : GameRepositoryProtocol {
    func updateFavorite(game: GameModel) -> Observable<Bool> {
        return local.updateFavorite(game: GameMapper.mapGameDomainsToEntities(input: game))
    }
    
    func findByIdGame(id: Int) -> Observable<Bool> {
        return local.findByID(id: id)
    }
 
    func getFavoriteList() -> Observable<[GameModel]> {
        return local.listGameData().map { GameMapper.mapGameEntitiesToDomains(input: $0)}
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
