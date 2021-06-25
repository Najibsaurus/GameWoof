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


class GameRepositoryMock:  Repository {
    
    typealias Request = String
    typealias Response = [GamingModel]

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
    
}
