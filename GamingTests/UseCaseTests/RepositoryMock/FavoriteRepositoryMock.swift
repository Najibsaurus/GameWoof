//
//  FavoriteRepositoryMock.swift
//  GamingTests
//
//  Created by Najib Abdillah on 25/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Foundation
import Core
import RxSwift

class FavoriteRepositoryMock: Repository {

    var isGameSaved = false
    var isGameUnsaved = false
    var fetchedGaming : [GamingEntity]?
    
    typealias Request = Any
    typealias Response = [GamingEntity]
    
    func execute(request: Any) -> Observable<[GamingEntity]> {
        return Observable<[GamingEntity]>.create { observer in
            guard let games = self.fetchedGaming else {
                observer.onError(NSError.gettingError(withMessage: "Invalid URL"))
                return Disposables.create()
            }
            observer.onNext(games)
          return Disposables.create()
        }
    }
    
    
    
}
