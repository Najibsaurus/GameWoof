//
//  GameInteractor.swift
//  Gaming
//
//  Created by Najib Abdillah on 08/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Foundation
import RxSwift

protocol GameUseCase {
    func getRequest() -> Observable<[GameModel]>
    func getSearch(by name: String) -> Observable<[GameModel]>
}
class GameInteractor: GameUseCase {
 
    private let repository: GameRepositoryProtocol
    required init(repository: GameRepositoryProtocol) {
      self.repository = repository
    }
    
    func getRequest() -> Observable<[GameModel]> {
        return repository.getRequest()
    }
    
    func getSearch(by name: String) -> Observable<[GameModel]> {
        return repository.getSearch(by: name)
    }
    
    
    
    

    
}
