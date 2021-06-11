//
//  GameViewModel.swift
//  Gaming
//
//  Created by Najib on 13/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import Foundation
import RxSwift


class GameViewModel : NSObject {
    
    let cellGameIdentifier = "gameListIdentifier"
    let gameCellnib = "GameCell"
    let gameUseCase : GameUseCase
    let dummyImage = "https://dummyimage.com/90x90/000/fff"
    let avatar = "https://d17ivq9b7rppb3.cloudfront.net/small/avatar/201905171011432535d9edbd268e421db5dc9a8f23256e.png"
    let name = "Najib Abdillah"
    let htmlFormat = "<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: 15\">%@</span>"
    let defaultRowHeight = 111
    let gameDetailIdentifier = "gameDetail"
    
    var delegate: GameViewModelDelegate?
    var gameList = [GameModel]()
    var detailData : DetailModel?
    private let disposeBag = RxSwift.DisposeBag()
        
    
    
    override init() {
        gameUseCase = Injection.init().providedGame()
    }
       
    
    func fetchDataGame() {
        
        gameUseCase.getRequest().observe(on: MainScheduler.instance).subscribe { result in
            self.gameList = result
        } onError: { error in
            self.delegate?.errorData(err: error)
        } onCompleted: {
            self.delegate?.completedFetchGame()
        }.disposed(by: disposeBag)
        
    }
    
    func showDetail(idGame: Int) {
        gameUseCase.getDetail(by: "\(idGame)").observe(on: MainScheduler.instance).subscribe { result in
            self.detailData = result
        } onError: { error in
            self.delegate?.errorData(err: error)
        } onCompleted: {
            self.delegate?.completedFetchDetail()
        }.disposed(by: disposeBag)
        
    }
    
    
    func searchGame(game: String){
        gameUseCase.getSearch(by: game).observe(on: MainScheduler.instance).subscribe { result in
            self.gameList = result
        } onError: { error in
            self.delegate?.errorData(err: error)
        } onCompleted: {
            self.delegate?.completedFetchGame()
        }.disposed(by: disposeBag)
  
    }
        
    
}

protocol GameViewModelDelegate {
    func completedFetchGame()
    func completedFetchDetail()
    func errorData(err: Error)
}


