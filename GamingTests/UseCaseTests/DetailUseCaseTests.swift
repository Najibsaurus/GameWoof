//
//  DetailUseCase.swift
//  GamingTests
//
//  Created by Najib Abdillah on 20/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

@testable import Gaming
import XCTest
import RxSwift
import Core


class DetailUseCaseTests: XCTestCase  {
    
    private var detailRepoMock : DetailGameRepositoryMock!
    
  
    var disposeBag: DisposeBag!
    private var detailMock : DetailGameModel!
    private var gameDummy : GamingModel!
    
    override func setUp() {
        detailRepoMock = DetailGameRepositoryMock()
        disposeBag = DisposeBag()
        gameDummy = GamingModel(id: 1234,
        backgroundImage: "https://media.rawg.io/media/screenshots/0bb/0bb7c4ac543768fd6c4dd849cc827310.jpeg",
        name: "Solomon's Keep", released: "2010-04-03", rating: 8.0)
    
        detailMock = DetailGameModel(id: 1234 , description: "FIFA 21 is a football simulation video game published by Electronic Arts as part of the FIFA series")
    }
    
    func testFavoriteGameMethod(){
        getExecuteUpdateFavorite(game: gameDummy)
        XCTAssertEqual(detailRepoMock.isGameSaved, true)
    }
    

    func testUnfavoriteGameMethod(){
        getExecuteUpdateFavorite(game: gameDummy)
        XCTAssertEqual(detailRepoMock.isGameUnsaved, false)
    }

    
    func testCompletedHandlerDetailGameResultIsInvalidData() {
        let result = execute(url: "\(Endpoints.Gets.detail.url)\(gameDummy.id)\(API.apiKey)", gamesIns: detailMock)
        verifyExecute(result, expectedUsers: detailRepoMock.fetchedDetail, isErrorExpected: false)
    }
    
    func testCompletedHandlerDetailGameResultIsSuccess() {
        let result = execute(url: "\(Endpoints.Gets.detail.url)\(gameDummy.id)\(API.apiKey)", gamesIns: nil)
        verifyExecute(result, expectedUsers: nil, isErrorExpected: true)
    }
    
    
    private func verifyExecute(_ result: (games: DetailGameModel?, error: Error?), expectedUsers: DetailGameModel?, isErrorExpected: Bool) {
        XCTAssertEqual(result.games, expectedUsers)
        XCTAssertEqual(result.error != nil, isErrorExpected)
    }
        
    private func getExecuteUpdateFavorite(game: GamingModel?) {
        detailRepoMock?.execute(request: game!).observe(on: MainScheduler.instance).subscribe { result in
            let fav = Converter.getBoolFromAny(paramAny: result)
            self.detailRepoMock.isGameSaved = !fav
        }.disposed(by: disposeBag)
    }
        
    private func execute(url: String, gamesIns: DetailGameModel?)  -> (games: DetailGameModel?, error: Error?){
        detailRepoMock.fetchedDetail = gamesIns
        var games: DetailGameModel?
        var error: Error?
        detailRepoMock?.execute(request: url).observe(on: MainScheduler.instance).subscribe { result in
            switch result {
            case .next(let game):
                games = game as? DetailGameModel
            case .error(let err):
                error = err
            case .completed:
                games = gamesIns
            }
        }.disposed(by: disposeBag)
        return (games, error)
    }
    
    
    override  func tearDown() {
        detailRepoMock = nil
        disposeBag = nil
        detailMock = nil
        gameDummy = nil
    }
}
