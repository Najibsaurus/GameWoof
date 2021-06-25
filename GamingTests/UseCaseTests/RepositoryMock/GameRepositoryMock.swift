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
import Core


class GameRepositoryMock: GameRepositoryProtocol, Repository {
    func getDetail(by id: String) -> Observable<DetailModel> {
        fatalError()
    }
    
 
    typealias Request = String
    typealias Response = [GamingModel]
    
    var isGameSaved = false
    var isGameUnsaved = false
    var isGameFound = false
    var isGameNotFound = false
    var fetchedGames: [GameModel]?
    var fetchedDetail : DetailGameModel?
    var fetchedGaming : [GamingModel]?
    

    
    func execute(request: String) -> Observable<[GamingModel]> {
        return Observable<[GamingModel]>.create { observer in
            guard let games = self.fetchedGaming else {
                observer.onError(NSError.gettingError(withMessage: "Invalid URL"))
                return Disposables.create()
            }
            observer.onNext(games)
          return Disposables.create()
        }
    }
    
    
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
    
    
    func findByIdGame(id: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            let games = self.isGameFound
            observer.onNext(games)
          return Disposables.create()
        }
    }
    
    func updateFavorite(game: GameModel) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            let games = self.isGameSaved
            observer.onNext(games)
          return Disposables.create()
        }
    }
}
