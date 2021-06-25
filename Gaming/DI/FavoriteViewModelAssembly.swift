//
//  FavoriteViewModelAssembly.swift
//  Gaming
//
//  Created by Najib Abdillah on 14/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Swinject
import RealmSwift

import Core
import Favorite
import Game



class FavoriteViewModelAssembly: Assembly {
  
    private let _gameMapper :GamingMapper
    private let _realm : Realm
    
    
    init(realm:Realm, mapper: GamingMapper) {
        _realm = realm
        _gameMapper = mapper
    }
    
    func assemble(container: Container) {
        container.register(FavoriteViewModel.self) { _  in
            let local = FavoriteLocalDataSource(realm: self._realm)
            let repository = FavoriteRepository(localdb: local, gamingMapper: self._gameMapper)
            let detailUseCase = Interactor(repository: repository)
            return FavoriteViewModel(interactor: detailUseCase )
        }
        
    }
    
}
