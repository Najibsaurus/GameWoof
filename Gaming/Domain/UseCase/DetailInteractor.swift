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
    func findById(id: Int) -> Observable<Bool>
    func updateFavorite(game: GameModel) -> Observable<Bool>
}

class DetailInteractor: DetailUseCase {
 
    private let repository: GameRepositoryProtocol
    required init(repository: GameRepositoryProtocol) {
      self.repository = repository
    }
    
    func getDetail(by id: String) -> Observable<DetailModel> {
        return repository.getDetail(by: id)
    }
    
    func updateFavorite(game: GameModel) -> Observable<Bool> {
        return repository.updateFavorite(game: game)
    }
    
    func findById(id: Int) -> Observable<Bool> {
        return repository.findByIdGame(id: id)
    }
    
}
