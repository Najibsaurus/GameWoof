//
//  GameViewModelAssembly.swift
//  Gaming
//
//  Created by Najib Abdillah on 14/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import RealmSwift
import Swinject
import Game
import Core



class GameViewModelAssembly: Assembly {
    
    private let _gameMapper :GamingMapper
    private let _network : NetworkServices
    
    
    init(gameNetwork: NetworkServices, mapper: GamingMapper) {
        _gameMapper = mapper
        _network = gameNetwork
    }
    
    func assemble(container: Container) {
        
        container.register(GameViewModel.self) { _ in
            let gameRemote = GameRemoteDataSource(network: self._network)
            let repository = GamingRepository(remoteDataSource: gameRemote, gamingMapper: self._gameMapper)
            let gameUseCase = Interactor(repository: repository)
            return GameViewModel(interactor: gameUseCase)
        }
        
    }
    
}
