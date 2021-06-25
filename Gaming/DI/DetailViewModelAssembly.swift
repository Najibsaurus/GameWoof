//
//  DetailViewModelAssembly.swift
//  Gaming
//
//  Created by Najib Abdillah on 14/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import RealmSwift
import Swinject
import Game
import Core
import Favorite


class DetailViewModelAssembly: Assembly {
    
    private let _gameMapper :DetailGamingMapper
    private let _network : NetworkServices
    private let _realm : Realm
    
    
    init(realm:Realm, gameNetwork: NetworkServices, mapper: DetailGamingMapper) {
        _realm = realm
        _gameMapper = mapper
        _network = gameNetwork
    }
    
    
    
    func assemble(container: Container) {
        container.register(DetailViewModel.self) { _ in
            let local = UpdateFavoriteLocalDataSource(realm: self._realm)
            let remote = DetailGameRemoteDataSource(network: self._network)
            let detailMapper = DetailGamingMapper()
            let repository = DetailGamingRepository(localDataSource: local, remoteDataSource: remote, gamingMapper: detailMapper)
            let detailUseCase = Interactor(repository: repository)
            return DetailViewModel(interactor: detailUseCase )
        }
        
    }
    
}
