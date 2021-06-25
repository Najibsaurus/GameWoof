//
//  LocalDataSourcce.swift
//  Core
//
//  Created by Najib Abdillah on 24/06/21.
//

import RxSwift

public protocol LocalDataSource {
  
    associatedtype Request
    associatedtype Response
    
    func listGameData() -> Observable<Response>
    func updateFavorite(game: Request) -> Observable<Response>
    func checkFavorite(game: Request) -> Observable<Response>

}
