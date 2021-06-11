//
//  FavoriteViewModel.swift
//  Gaming
//
//  Created by Najib on 17/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class FavoriteViewModel : NSObject {
 
    let favoriteUseCase : FavoriteUseCase
    var delegate: FavoriteViewModelDelegate?
    var gameList = [GameModel]()
    private let disposeBag = RxSwift.DisposeBag()
    
    override init() {
        favoriteUseCase = Injection.init().providedFavorite()
    }
    
    
    func addToFavorite(game: GameModel)  {
        favoriteUseCase.favorite(game: game)
    }
    
    
    func findById(id: Int) -> Bool {
        return favoriteUseCase.findById(id: id)
    }
    
    func unFavorite(game: GameModel)  {
        favoriteUseCase.unFavorite(game: game)
    }
    
    
    func fetchData(){
        favoriteUseCase.getFavoriteList().observe(on: MainScheduler.instance).subscribe { result in
            self.gameList = result
        } onError: { error in
            self.delegate?.errorData(error: error)
        } onCompleted: {
            self.delegate?.completedFetchFavorite()
        }.disposed(by: disposeBag)

    }
}

 
protocol FavoriteViewModelDelegate {
    func errorData(error: Error)
    func completedFetchFavorite()
    func fetchDataDelegate()
}


