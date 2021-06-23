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
    func listGameData() -> Observable<[GameEntity]>
    func findByID(id: Int) -> Observable<Bool>
    func updateFavorite(game: GameEntity) -> Observable<Bool>
}

class GameStorageDataSource : NSObject {
    
    private let realm : Realm?
    
    init(realm: Realm?){
        self.realm = realm
    }
    
}

extension GameStorageDataSource: GameStorageProtocol {
    
    func updateFavorite(game: GameEntity) -> Observable<Bool> {
        let item = realm?.object(ofType: GameEntity.self, forPrimaryKey: game.id)
        return Observable<Bool>.create { observer in
         
          if let realm = self.realm {
            let isHaveFound  = item != nil
            
            if isHaveFound {
                do {
                  try realm.write {
                    realm.delete(item!)
                  }
                } catch {
                  print(DatabaseError.requestFailed)
                }
            } else {
                do {
                  try realm.write {
                      realm.create(GameEntity.self, value: game, update: .all)
                  }
                } catch {
                  print(DatabaseError.requestFailed)
                }
            }
            observer.onNext(isHaveFound)
            observer.onCompleted()
          } else {
            observer.onError(DatabaseError.invalidInstance)
          }
          return Disposables.create()
        }
    }
    
    func findByID(id: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
          if let realm = self.realm {
            let isHaveFound  = realm.object(ofType: GameEntity.self, forPrimaryKey: "\(id)") != nil
            observer.onNext(isHaveFound)
            observer.onCompleted()
          } else {
            observer.onError(DatabaseError.invalidInstance)
          }
          return Disposables.create()
        }
    }
    

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
