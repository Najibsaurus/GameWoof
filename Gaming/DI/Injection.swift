//
//  Injection.swift
//  Gaming
//
//  Created by Najib Abdillah on 09/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    private func providedRepository(url:String = "") -> GameRepositoryProtocol {
        let realm = try? Realm()
        let local : GameStorageDataSource = GameStorageDataSource.sharedInstance(realm)
        let networkService = NetworkService(url: URL(string: url))
        let remote: RemoteDataSource = RemoteDataSource.sharedInstance(networkService)
        return GameRepository.sharedInstance(local,remote)
    }
    
    
    func providedGame(url:String = Endpoints.Gets.games.url) -> GameUseCase {
        let repository = providedRepository(url: url)
        return GameInteractor(repository: repository)
    }
    
    func providedFavorite() -> FavoriteUseCase {
        let repository = providedRepository()
        return FavoriteInteractor(repository: repository)
    }
    
    
    
    
    
}
