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
}

class FavoriteInteractor: FavoriteUseCase {
    func getFavoriteList() -> Observable<[GameModel]> {
        return repository.getFavoriteList()
    }
     
    private let repository: GameRepositoryProtocol
    
    required init(repository: GameRepositoryProtocol) {
      self.repository = repository
    }
    
    
}
