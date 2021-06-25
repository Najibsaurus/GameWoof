//
//  GameRemoteDataSource.swift
//  Game
//
//  Created by Najib Abdillah on 24/06/21.
//

import Foundation
import Core
import RxSwift


public struct GameRemoteDataSource: DataSource  {
    
    public typealias Request = String
    public typealias Response = [ResultGaming]

    
    private var networking : NetworkProtocol
      
    public init(network: NetworkProtocol){
          self.networking = network
    }
      
    public func execute(request: String) -> Observable<[ResultGaming]> {
        self.networking.url = URL(string: "\(String(describing: request))")
        return Observable<[ResultGaming]>.create { observer in
            guard self.networking.url != nil else {
                observer.onError(NSError.gettingError(withMessage: "Invalid URL"))
                return Disposables.create()
            }
            self.networking.getRequest { (result: Result<CallGaming, NSError>) in
                switch result {
                case .success(let game):
                        observer.onNext(game.results)
                        observer.onCompleted()
                case .failure(let error):
                        observer.onError(error)
                }
            }    
          return Disposables.create()
        }
    }
    
}
