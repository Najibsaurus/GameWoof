//
//  GameStorage.swift
//  Gaming
//
//  Created by Najib Abdillah on 08/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import RealmSwift
import RxSwift

protocol GameStorageProtocol {
    func favorite(game: GameEntity)
    func unFavorite(game: GameEntity)
    func listGameData() -> Observable<[GameEntity]>
    func findByID(id: Int) -> Bool
    
}

final class GameStorageDataSource : NSObject {
    
    private let realm : Realm?
    
    private init(realm: Realm?){
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> GameStorageDataSource = {
        realmDatabase in return GameStorageDataSource(realm: realmDatabase)

    }
}

extension GameStorageDataSource: GameStorageProtocol {
   
    func listGameData() -> Observable<[GameEntity]> {
        return Observable<[GameEntity]>.create { observer in
          if let realm = self.realm {
            let favorites: Results<GameEntity> = {
              realm.objects(GameEntity.self)
            }()
            observer.onNext(favorites.toArray())
            observer.onCompleted()
          } else {
            observer.onError(DatabaseError.invalidInstance)
          }
          return Disposables.create()
        }
    }
    
    
    

    func findByID(id: Int) -> Bool {
        return self.realm?.object(ofType: GameEntity.self, forPrimaryKey: "\(id)") != nil
    }
        
    
    func favorite(game: GameEntity) {
        try! self.realm?.write{
            self.realm?.create(GameEntity.self, value: game, update: .all)
        }
    }
    
    func unFavorite(game: GameEntity) {
        guard let item = self.realm?.object(ofType: GameEntity.self, forPrimaryKey: game.id) else {
            return
        }
        try! self.realm?.write {
            self.realm?.delete(item)
        }
    }
    

    
}

extension Results {
    func toArray() -> [Element] {
        return compactMap { $0 }
    }
}

enum URLError: LocalizedError {

  case invalidResponse
  case addressUnreachable(URL)
  
  var errorDescription: String? {
    switch self {
    case .invalidResponse: return "The server responded with garbage."
    case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
    }
  }

}

enum DatabaseError: LocalizedError {

  case invalidInstance
  case requestFailed
  
  var errorDescription: String? {
    switch self {
    case .invalidInstance: return "Database can't instance."
    case .requestFailed: return "Your request failed."
    }
  }

}