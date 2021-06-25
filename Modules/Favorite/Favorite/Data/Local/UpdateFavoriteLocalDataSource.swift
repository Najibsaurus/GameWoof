//
//  UpdateFavoriteLocalDataSource.swift
//  Favorite
//
//  Created by Najib Abdillah on 24/06/21.
//

import Foundation
import Core
import RxSwift
import RealmSwift


public class UpdateFavoriteLocalDataSource: LocalDataSource {
  
    public typealias Request = Any
    public typealias Response = Any
    private let realm: Realm?
    
    public init(realm: Realm?) {
        self.realm = realm
    }

    public func listGameData() -> Observable<Any> {
        fatalError()
    }
 
    public func checkFavorite(game: Any) -> Observable<Any> {
        let idGame = game as? String
        let item = self.realm?.object(ofType: GamingEntity.self, forPrimaryKey: idGame)
        return Observable<Any>.create { observer in
            if self.realm != nil {
            let isHaveFound  = item != nil
            observer.onNext(isHaveFound)
            observer.onCompleted()
          } else {
            observer.onError(DatabaseError.invalidInstance)
          }
          return Disposables.create()
        }
    }
    
    
    public func updateFavorite(game: Any) -> Observable<Any> {
        let gameEntity = game as? GamingEntity
        let item = self.realm?.object(ofType: GamingEntity.self, forPrimaryKey: gameEntity?.id)
        return Observable<Any>.create { observer in
          if let realm = self.realm {
            let isHaveFound  = item != nil
            
            if isHaveFound {
                do {
                  try realm.write {
                    realm.delete(item!)
                  }
                } catch {
                    print()
                }
            } else {
                do {
                  try realm.write {
                      realm.create(GamingEntity.self, value: game, update: .all)
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

}
