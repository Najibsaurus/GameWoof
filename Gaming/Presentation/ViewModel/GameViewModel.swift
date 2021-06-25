//
//  GameViewModel.swift
//  Gaming
//
//  Created by Najib on 13/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import Foundation
import RxSwift
import Core
import Game


protocol GameViewModelDelegate {
    func completedFetchGame(gamesList: [GamingModel]?)
    func errorData(err: Error)
}

struct GameViewModelStatic {
    
    static let cellGameIdentifier = "gameListIdentifier"
    static let gameCellnib = "GameCell"
    static let dummyImage = "https://dummyimage.com/90x90/000/fff"
    static let htmlFormat = "<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: 15\">%@</span>"
    static let defaultRowHeight = 111
    static let gameDetailIdentifier = "gameDetail"

}


class GameViewModel : NSObject {
    
    private var  gameUseCase : Interactor<String, [GamingModel], GamingRepository<GameRemoteDataSource,GamingMapper>>
    var gameList = [GamingModel]()
    var detailData : DetailGameModel?
    private let disposeBag = RxSwift.DisposeBag()
    var delegate: GameViewModelDelegate?
    
    
    init(interactor: Interactor<String, [GamingModel], GamingRepository<GameRemoteDataSource,GamingMapper>>) {
        self.gameUseCase = interactor
    }
       
    
    func fetchDataGame() {
        execute(url: Endpoints.Gets.games.url)
    }
    

    func searchGame(game: String){
        execute(url: "\(Endpoints.Gets.search.url)\(game)\(API.apiKey)")
    }
    
    func execute(url : String) {
        gameUseCase.execute(request: url).observe(on: MainScheduler.instance).subscribe { result in
            switch result {
            case .next(let games):
                self.gameList = games
            case .error(let error):
                self.delegate?.errorData(err: error)
            case .completed:
                self.delegate?.completedFetchGame(gamesList: self.gameList)
            }
        }.disposed(by: disposeBag)
    }
    
}
