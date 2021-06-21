//
//  DetailInteractor.swift
//  Gaming
//
//  Created by Najib Abdillah on 14/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    func getDetail(by id: String) -> Observable<DetailModel>
    func favorite(game: GameModel)
    func unFavorite(game: GameModel)
    func findById(id: Int) -> Bool
}

class DetailInteractor: DetailUseCase {
 
    private let repository: GameRepositoryProtocol
    required init(repository: GameRepositoryProtocol) {
      self.repository = repository
    }
    
    func getDetail(by id: String) -> Observable<DetailModel> {
        return repository.getDetail(by: id)
    }
    
    func favorite(game: GameModel) {
        repository.favorite(game: game)
    }
    
    func unFavorite(game: GameModel) {
        repository.unFavorite(game: game)
    }
    
    func findById(id: Int) -> Bool {
        repository.findByIdGame(id: id)
    }
    
    
}
