//
//  GameUseCaseTests.swift
//  GamingTests
//
//  Created by Najib Abdillah on 13/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

@testable import Gaming
import XCTest
import RxSwift

class GameUseCaseTest: XCTestCase {
    
    
    private var repositoryMock : GameRepositoryMock!
    private var ins : GameInteractor!
    var disposeBag: DisposeBag!
    private var gameMock : [GameModel] = []
    private var searchMock : [GameModel] = []
    
    
    override func setUp() {
        repositoryMock = GameRepositoryMock()
        ins = GameInteractor(repository: repositoryMock)
        disposeBag = DisposeBag()
        
        let game = GameModel(id: 12,
        backgroundImage: "https://media.rawg.io/media/screenshots/0bb/0bb7c4ac543768fd6c4dd849cc827310.jpeg",
        name: "Solomon's Keep", released: "2010-04-03", rating: 8.0)
        gameMock = [game]
    }
    
    
    func testCompletedHandlerGameListResultIsInvalidData() {
        let result = getExecuteGameList(gamesIns: gameMock)
        verifyExecute(result, expectedUsers: repositoryMock.fetchedGames, isErrorExpected: false)
    }
    
    func testCompletedHandlerGameListResultIsSuccess() {
        let result = getExecuteGameList(gamesIns: nil)
        verifyExecute(result, expectedUsers: nil, isErrorExpected: true)
    }
    
    
    func testCompletedHandlerSearchResultIsInvalidData() {
        let result = getExecuteSearch(gamesSearch: searchMock)
        verifyExecute(result, expectedUsers: repositoryMock.fetchedGames, isErrorExpected: false)
    }
    
    func testCompletedHandlerSearchResultIsSuccess() {
        let result = getExecuteSearch(gamesSearch: nil)
        verifyExecute(result, expectedUsers: nil, isErrorExpected: true)
    }
    
    
    private func verifyExecute(_ result: (games: [GameModel]?, error: Error?), expectedUsers: [GameModel]?, isErrorExpected: Bool) {
        XCTAssertEqual(result.games, expectedUsers)
        XCTAssertEqual(result.error != nil, isErrorExpected)
    }
    
    private func getExecuteGameList(gamesIns: [GameModel]?) -> (games: [GameModel]?, error: Error?) {
        repositoryMock.fetchedGames = gamesIns
        var games: [GameModel]?
        var error: Error?
        ins.getRequest().observe(on: MainScheduler.instance).subscribe{ result in
            switch result {
            case .next(let game):
                print(game)
                games = game
            case .error(let err):
                error = err
            case .completed:
                games = self.repositoryMock.fetchedGames

            }
        }.disposed(by: disposeBag)
    
        return (games, error)
    }
    
    
    private func getExecuteSearch(gamesSearch: [GameModel]?) -> (games: [GameModel]?, error: Error?) {
        repositoryMock.fetchedGames = gamesSearch
        var games: [GameModel]?
        var error: Error?
        ins.getSearch(by: "DOTA").observe(on: MainScheduler.instance).subscribe { result in
            switch result {
            case .next(let game):
                games = game
            case .error(let err):
                error = err
            case .completed:
                games = self.repositoryMock.fetchedGames
            }
        }.disposed(by: disposeBag)
        
        return(games, error)
    }
    
    
    override  func tearDown() {
        repositoryMock = nil
        ins = nil
        disposeBag = nil
        searchMock = []
        gameMock = []
    }
    
}
