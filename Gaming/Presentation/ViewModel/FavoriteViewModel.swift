//
//  FavoriteViewModel.swift
//  Gaming
//
//  Created by Najib on 17/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import Foundation
import RxSwift

import Core
import Favorite
import Game

class FavoriteViewModel : NSObject {
 
    private var favoriteUseCase : Interactor<Any, [GamingModel], FavoriteRepository<FavoriteLocalDataSource,GamingMapper>>
    
    var delegate: FavoriteViewModelDelegate?
    var gameList = [GamingModel]()
    private let disposeBag = RxSwift.DisposeBag()

    init(interactor: Interactor<Any, [GamingModel], FavoriteRepository<FavoriteLocalDataSource,GamingMapper>>) {
        self.favoriteUseCase = interactor
    }

    
    func fetchData(){
        favoriteUseCase.execute(request: (Any).self).observe(on: MainScheduler.instance).subscribe { result in
            self.gameList = result
        } onError: { error in
            self.delegate?.errorData(error: error)
        } onCompleted: {
            self.delegate?.completedFetchFavorite(gamesList: self.gameList)
        }.disposed(by: disposeBag)
    

    }
}

 
protocol FavoriteViewModelDelegate {
    func errorData(error: Error)
    func completedFetchFavorite(gamesList: [GamingModel]?)
}
