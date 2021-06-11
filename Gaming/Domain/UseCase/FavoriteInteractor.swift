//
//  FavoriteInteractor.swift
//  Gaming
//
//  Created by Najib Abdillah on 11/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    func getFavoriteList() -> Observable<[GameModel]>
    func favorite(game: GameModel)
    func unFavorite(game: GameModel)
    func findById(id: Int) -> Bool
}

class FavoriteInteractor: FavoriteUseCase {
    func getFavoriteList() -> Observable<[GameModel]> {
        return repository.getFavoriteList()
    }
     

    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
      self.repository = repository
    }
    
    
    func favorite(game: GameModel) {
        repository.favorite(game: game)
    }
    
    func unFavorite(game: GameModel) {
        repository.unFavorite(game: game)
    }
    
    func findById(id: Int) -> Bool {
        repository.findById(id: id)
    }
    
    
    
    
}
