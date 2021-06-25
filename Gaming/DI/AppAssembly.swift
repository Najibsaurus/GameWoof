//
//  AppAssembly.swift
//  Gaming
//
//  Created by Najib Abdillah on 14/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Swinject
import Game
import Core
import Favorite
import RealmSwift

class AppAssembly {
    
    private let container = Container()
    let assembler: Assembler
    
    init() {
        
        let realm = try? Realm()
        let network = NetworkServices(url: URL(string: Endpoints.Gets.games.url))
        let gameMapper = GamingMapper()
        let detailMapper = DetailGamingMapper()
        
        assembler = Assembler([GameViewModelAssembly(gameNetwork: network, mapper: gameMapper),
                               DetailViewModelAssembly(realm: realm!, gameNetwork: network, mapper: detailMapper),
                               FavoriteViewModelAssembly(realm: realm!, mapper: gameMapper)],container: container)
            
        
    }
    
    
}
