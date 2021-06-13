//
//  GameViewModelAssembly.swift
//  Gaming
//
//  Created by Najib Abdillah on 14/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import RealmSwift
import Swinject

class GameViewModelAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(GameRepository.self) { _ in
            let realm = try? Realm()
            let local = GameStorageDataSource(realm: realm)
            let network = NetworkService(url: URL(string: Endpoints.Gets.games.url))
            let remote = RemoteDataSource(network: network)
            return GameRepository(local: local, remote: remote)
        }
        
        container.register(GameViewModel.self) { resolver in
            let repository = resolver.resolve(GameRepository.self)!
            let gameUseCase = GameInteractor(repository: repository)
            return GameViewModel(gameUseCase: gameUseCase )
        }
        
    }
    
}
