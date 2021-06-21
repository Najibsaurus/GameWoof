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


class DetailUseCaseTests: XCTestCase  {
    
    private var repositoryMock : GameRepositoryMock!
    private var ins : DetailInteractor!
    var disposeBag: DisposeBag!
    private var detailMock : DetailModel!
    private var gameDummy : GameModel!
    
    override func setUp() {
        repositoryMock = GameRepositoryMock()
        repositoryMock.fetchedGames = nil
        ins = DetailInteractor(repository: repositoryMock)
        disposeBag = DisposeBag()
        
        gameDummy = GameModel(id: 1234,
        backgroundImage: "https://media.rawg.io/media/screenshots/0bb/0bb7c4ac543768fd6c4dd849cc827310.jpeg",
        name: "Solomon's Keep", released: "2010-04-03", rating: 8.0)
        
        detailMock = DetailModel(id: 1234 , description: "FIFA 21 is a football simulation video game published by Electronic Arts as part of the FIFA series")
    }
    
    func testFavoriteGameMethod(){
        ins.favorite(game: gameDummy)
        XCTAssertEqual(repositoryMock.isGameSaved, true)
    }
    
    func testGameFoundMethod(){
        repositoryMock.isGameFound = ins.findById(id: 1234)
        XCTAssertEqual(repositoryMock.isGameFound, true)
    }
    

    func testUnfavoriteGameMethod(){
        ins.unFavorite(game: gameDummy)
        XCTAssertEqual(repositoryMock.isGameUnsaved, false)
    }

    
    func testCompletedHandlerDetailGameResultIsInvalidData() {
        let result = getExecuteDetail(gamesIns: detailMock)
        verifyExecute(result, expectedUsers: repositoryMock.fetchedDetail, isErrorExpected: false)
    }
    
    func testCompletedHandlerDetailGameResultIsSuccess() {
        let result = getExecuteDetail(gamesIns: nil)
        verifyExecute(result, expectedUsers: nil, isErrorExpected: true)
    }
    
    
    private func verifyExecute(_ result: (games: DetailModel?, error: Error?), expectedUsers: DetailModel?, isErrorExpected: Bool) {
        XCTAssertEqual(result.games, expectedUsers)
        XCTAssertEqual(result.error != nil, isErrorExpected)
    }
    
    
    
    
    private func getExecuteDetail(gamesIns: DetailModel?) -> (games: DetailModel?, error: Error?) {
        repositoryMock.fetchedDetail = gamesIns
        var games: DetailModel?
        var error: Error?
        ins.getDetail(by: "1234").observe(on: MainScheduler.instance).subscribe{ result in
            switch result {
            case .next(let game):
                games = game
            case .error(let err):
                error = err
            case .completed:
                games = self.repositoryMock.fetchedDetail

            }
        }.disposed(by: disposeBag)
        return (games, error)
    }
    
    override  func tearDown() {
        repositoryMock = nil
        ins = nil
        disposeBag = nil
        detailMock = nil
        gameDummy = nil
    }
}
