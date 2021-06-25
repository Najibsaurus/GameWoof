//
//  DetailGameRepositoryMock.swift
//  GamingTests
//
//  Created by Najib Abdillah on 24/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

@testable import Gaming
import Foundation
import RxSwift
import Core


class DetailGameRepositoryMock:  Repository {
 
    typealias Request = Any
    typealias Response = Any
    
    var fetchedDetail : DetailGameModel?
    var isGameSaved = false
    var isGameUnsaved = false

    func execute(request: Any) -> Observable<Any> {
        return Observable<Any>.create { observer in
            guard let games = self.fetchedDetail else {
                observer.onError(NSError.gettingError(withMessage: "Invalid URL"))
                return Disposables.create()
            }
            observer.onNext(games)
          return Disposables.create()
        }
    }
    
}
