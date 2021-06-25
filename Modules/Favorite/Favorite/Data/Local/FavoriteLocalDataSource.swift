//
//  FavoriteLocalDataSource.swift
//  Favorite
//
//  Created by Najib Abdillah on 24/06/21.
//

import Foundation
import Core
import RxSwift
import RealmSwift


public class FavoriteLocalDataSource: LocalDataSource {

    public typealias Request = Any
    public typealias Response = [GamingEntity]
    private let realm: Realm?
    
    public init(realm: Realm?) {
        self.realm = realm
    }

    public func listGameData() -> Observable<[GamingEntity]> {
        return Observable<[GamingEntity]>.create { observer in
          if let realm = self.realm {
            let favorites: Results<GamingEntity> = {
              realm.objects(GamingEntity.self)
            }()
            
            observer.onNext(favorites.toArray())
            observer.onCompleted()
          } else {
            observer.onError(DatabaseError.invalidInstance)
          }
          return Disposables.create()
        }
    }
    
    
    public func updateFavorite(game: Any) -> Observable<[GamingEntity]> {
        fatalError()
    }
    
    public func checkFavorite(game: Any) -> Observable<[GamingEntity]> {
        fatalError()
    }
    
}
