//
//  DetailViewModel.swift
//  Gaming
//
//  Created by Najib Abdillah on 14/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Foundation
import RxSwift
import Core
import Game
import Favorite



protocol DetailViewModelDelegate {
    func completedFetchDetailGame(game: DetailGameModel?)
    func errorData(err: Error)
}

class DetailViewModel: NSObject {
    
    private var  detailUseCase : Interactor<Any, Any, DetailGamingRepository<UpdateFavoriteLocalDataSource,DetailGameRemoteDataSource,DetailGamingMapper>>
    
    
    var detailData : DetailGameModel?
    private let disposeBag = RxSwift.DisposeBag()
    var delegate: DetailViewModelDelegate?
    var isFavorite : Bool?

    
    init(interactor: Interactor<Any, Any, DetailGamingRepository<UpdateFavoriteLocalDataSource,DetailGameRemoteDataSource,DetailGamingMapper>>) {
        self.detailUseCase = interactor
    }
 
    func execute(url : String) {
        
        detailUseCase.execute(request: url).observe(on: MainScheduler.instance).subscribe { result in
            switch result {
            case .next(let game):
                self.detailData = game as? DetailGameModel
            case .error(let error):
                self.delegate?.errorData(err: error)
            case .completed:
                self.delegate?.completedFetchDetailGame(game:self.detailData )
            }
        }.disposed(by: disposeBag)
    }
    
    
    func showDetail(idGame: String) {
        
        execute(url: "\(Endpoints.Gets.detail.url)\(idGame)\(API.apiKey)")
    }
    
    func checkGame(game: String){
        detailUseCase.execute(request: game).observe(on: MainScheduler.instance).subscribe { result in
            self.isFavorite = result as? Bool
        } onError: { error in
            self.delegate?.errorData(err: error)
        }.disposed(by: disposeBag)
    }
    
    func updateFavorite(game: GamingModel) {
        detailUseCase.execute(request: game).observe(on: MainScheduler.instance).subscribe { result in
            let fav = result as? Bool
            self.isFavorite = !fav!
        } onError: { error in
            self.delegate?.errorData(err: error)
        }.disposed(by: disposeBag)
    }
    

}
