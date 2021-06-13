//
//  FavoriteViewModel.swift
//  Gaming
//
//  Created by Najib on 17/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import Foundation
import RxSwift


class FavoriteViewModel : NSObject {
 
    let favoriteUseCase : FavoriteUseCase
    var delegate: FavoriteViewModelDelegate?
    var gameList = [GameModel]()
    private let disposeBag = RxSwift.DisposeBag()
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    func fetchData(){
        favoriteUseCase.getFavoriteList().observe(on: MainScheduler.instance).subscribe { result in
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
    func completedFetchFavorite(gamesList: [GameModel]?)
}
