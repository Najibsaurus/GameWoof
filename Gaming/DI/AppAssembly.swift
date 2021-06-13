//
//  AppAssembly.swift
//  Gaming
//
//  Created by Najib Abdillah on 14/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Swinject

class AppAssembly {
    
    private let container = Container()
    let assembler : Assembler
    
    init() {
        assembler = Assembler([
        GameViewModelAssembly(), DetailViewModelAssembly(), FavoriteViewModelAssembly()],
        container: container)
        
    }
    
    
}
