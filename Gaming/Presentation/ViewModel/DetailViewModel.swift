//
//  DetailViewModel.swift
//  Gaming
//
//  Created by Najib Abdillah on 14/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Foundation
import RxSwift


protocol DetailViewModelDelegate {
    func completedFetchDetailGame(game: DetailModel?)
    func errorData(err: Error)
}

class DetailViewModel: NSObject {
    
    private var detailUseCase : DetailUseCase
    var detailData : DetailModel?
    private let disposeBag = RxSwift.DisposeBag()
    var delegate: DetailViewModelDelegate?

    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    func showDetail(idGame: Int) {
        detailUseCase.getDetail(by: "\(idGame)").observe(on: MainScheduler.instance).subscribe { result in
             self.detailData = result
         } onError: { error in
             self.delegate?.errorData(err: error)
         } onCompleted: {
            self.delegate?.completedFetchDetailGame(game: self.detailData)
         }.disposed(by: disposeBag)
    }
    
    func addToFavorite(game: GameModel)  {
        detailUseCase.favorite(game: game)
    }
    
    func findById(id: Int) -> Bool {
        return detailUseCase.findById(id: id)
    }
    
    func unFavorite(game: GameModel)  {
        detailUseCase.unFavorite(game: game)
    }
    
    
}
