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
    var isFavorite : Bool?

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
    

    
    func findById(id: Int) {
        detailUseCase.findById(id: id).observe(on: MainScheduler.instance).subscribe { result in
            self.isFavorite = result
        }.disposed(by: disposeBag)
    }
    
    func updateFavorite(game: GameModel) {
        detailUseCase.updateFavorite(game: game).observe(on: MainScheduler.instance).subscribe { result in
            self.isFavorite = !result
            
        }.disposed(by: disposeBag)
    }
    
    
}
