//
//  GameRepositoryMock.swift
//  GamingTests
//
//  Created by Najib Abdillah on 13/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

@testable import Gaming
import Foundation
import RxSwift

class GameRepositoryMock: GameRepositoryProtocol {

    
    var isGameSaved = false
    var isGameUnsaved = false
    var isGameFound = false
    var isGameNotFound = false
    var fetchedGames: [GameModel]?
    var fetchedDetail : DetailModel?
    
    
    func getRequest() -> Observable<[GameModel]> {
        return Observable<[GameModel]>.create { observer in
            guard let games = self.fetchedGames else {
                observer.onError(NSError.gettingError(withMessage: "Invalid URL"))
                return Disposables.create()
            }
            observer.onNext(games)
          return Disposables.create()
        }
        
    }
    
    func getDetail(by id: String) -> Observable<DetailModel> {
        return Observable<DetailModel>.create { observer in
            guard let games = self.fetchedDetail else {
                observer.onError(NSError.gettingError(withMessage: "Invalid URL"))
                return Disposables.create()
            }
            observer.onNext(games)
          return Disposables.create()
        }
    }
    
    func getSearch(by name: String) -> Observable<[GameModel]> {
        return Observable<[GameModel]>.create { observer in
            guard let games = self.fetchedGames else {
                observer.onError(NSError.gettingError(withMessage: "Invalid URL"))
                return Disposables.create()
            }
            observer.onNext(games)
          return Disposables.create()
        }
    }
    
    
    func getFavoriteList() -> Observable<[GameModel]> {
        return Observable<[GameModel]>.create { observer in
            guard let games = self.fetchedGames else {
                observer.onError(NSError.gettingError(withMessage: "Invalid URL"))
                return Disposables.create()
            }
            observer.onNext(games)
          return Disposables.create()
        }
    }
    
    func favorite(game: GameModel) {
        isGameSaved = true
        
    }
    
    func unFavorite(game: GameModel) {
        isGameUnsaved = false
    }
    
    func findByIdGame(id: Int) -> Bool {
        isGameFound = true
        return isGameFound
    }
}
