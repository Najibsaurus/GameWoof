//
//  RemoteDataSource.swift
//  Gaming
//
//  Created by Najib Abdillah on 08/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Foundation
import RxSwift


protocol RemoteDataSourceProtocol {
    
    func getRequest() -> Observable<[ResultGame]>
    func getDetail(by id: String) -> Observable<DetailCall>
    func getSearch(by name: String) -> Observable<[ResultGame]>
}

class RemoteDataSource: NSObject {

  private var networking : NetworkServiceProtocol
    
    init(network: NetworkServiceProtocol){
        self.networking = network
    }
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getSearch(by name: String) -> Observable<[ResultGame]> {
        networking.url = URL(string: "\(Endpoints.Gets.search.url)\(name)\(API.apiKey)")
        return Observable<[ResultGame]>.create { observer in
            guard self.networking.url != nil else {
                observer.onError(NSError.gettingError(withMessage: "Invalid URL"))
                return Disposables.create()
            }
            self.networking.getRequest { (result: Result<CallGame, NSError>) in
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
    
    
    func getDetail(by id: String)-> Observable<DetailCall> {
        networking.url = URL(string: "\(Endpoints.Gets.detail.url)\(id)\(API.apiKey)")
        return Observable<DetailCall>.create { observer in
            guard self.networking.url != nil else {
                observer.onError(NSError.gettingError(withMessage: "Invalid URL"))
                return Disposables.create()
            }
            self.networking.getRequest { (result: Result<DetailCall, NSError>) in
                switch result {
                    case .success(let game):
                        observer.onNext(game)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                }
            }
    
          return Disposables.create()
        }
    }
    
        
    func getRequest() -> Observable<[ResultGame]> {
        return Observable<[ResultGame]>.create { observer in
            guard self.networking.url != nil else {
                observer.onError(NSError.gettingError(withMessage: "Invalid URL"))
                return Disposables.create()
            }
            self.networking.getRequest { (result: Result<CallGame, NSError>) in
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

