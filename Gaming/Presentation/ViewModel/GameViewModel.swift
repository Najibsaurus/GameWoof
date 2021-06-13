//
//  GameViewModel.swift
//  Gaming
//
//  Created by Najib on 13/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import Foundation
import RxSwift


protocol GameViewModelDelegate {
    func completedFetchGame(gamesList: [GameModel]?)
    func errorData(err: Error)
}

struct GameViewModelStatic {
    
    static let cellGameIdentifier = "gameListIdentifier"
    static let gameCellnib = "GameCell"
    static let dummyImage = "https://dummyimage.com/90x90/000/fff"
    static let avatar = "https://d17ivq9b7rppb3.cloudfront.net/small/avatar/201905171011432535d9edbd268e421db5dc9a8f23256e.png"
    static let name = "Najib Abdillah"
    static let htmlFormat = "<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: 15\">%@</span>"
    static let defaultRowHeight = 111
    static let gameDetailIdentifier = "gameDetail"

}


class GameViewModel : NSObject {
    

    private var  gameUseCase : GameUseCase
    var gameList = [GameModel]()
    var detailData : DetailModel?
    private let disposeBag = RxSwift.DisposeBag()
    var delegate: GameViewModelDelegate?
    
    
    init(gameUseCase: GameUseCase) {
        self.gameUseCase = gameUseCase
    }
       
    
    func fetchDataGame() {
        
        gameUseCase.getRequest().observe(on: MainScheduler.instance).subscribe { result in
            self.gameList = result
        } onError: { error in
            self.delegate?.errorData(err: error)
        } onCompleted: {
            self.delegate?.completedFetchGame(gamesList: self.gameList)
        }.disposed(by: disposeBag)
        
    }
    

    func searchGame(game: String){
        gameUseCase.getSearch(by: game).observe(on: MainScheduler.instance).subscribe { result in
               self.gameList = result
           } onError: { error in
               self.delegate?.errorData(err: error)
           } onCompleted: {
            self.delegate?.completedFetchGame(gamesList: self.gameList)
           }.disposed(by: disposeBag)
  
    }
        
    
}


