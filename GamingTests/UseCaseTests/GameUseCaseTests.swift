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
import Core



class GameUseCaseTest: XCTestCase {
    
    private var repositoryMock : GameRepositoryMock!
    var disposeBag: DisposeBag!
    private var gameMock : [GamingModel] = []
    private var searchMock : [GamingModel] = []
        
    override func setUp() {
        repositoryMock = GameRepositoryMock()
        disposeBag = DisposeBag()
        let game = GamingModel(id: 12,
        backgroundImage: "https://media.rawg.io/media/screenshots/0bb/0bb7c4ac543768fd6c4dd849cc827310.jpeg",
        name: "Solomon's Keep", released: "2010-04-03", rating: 8.0)
        gameMock = [game]
    }
    
    func testCompletedHandlerGameListResultIsInvalidData() {
        let result = execute(url: Endpoints.Gets.games.url, gamesIns: gameMock)
        verifying(result, expectedUsers: repositoryMock.fetchedGaming, isErrorExpected: false)
    }
    
    func testCompletedHandlerGameListResultIsSuccess() {
        let result = execute(url: Endpoints.Gets.games.url, gamesIns: nil)
        verifying(result, expectedUsers: nil, isErrorExpected: true)
    }
    
    func testCompletedHandlerSearchResultIsInvalidData() {
        let result = execute(url: "\(Endpoints.Gets.search.url)\(gameMock[0].name)\(API.apiKey)", gamesIns: searchMock)
        verifying(result, expectedUsers: repositoryMock.fetchedGaming, isErrorExpected: false)
    }
    
    func testCompletedHandlerSearchResultIsSuccess() {
        let result = execute(url: "\(Endpoints.Gets.search.url)\(gameMock[0].name)\(API.apiKey)", gamesIns: nil)
        verifying(result, expectedUsers: nil, isErrorExpected: true)
    }
    
    private func verifying(_ result: (games: [GamingModel]?, error: Error?), expectedUsers: [GamingModel]?, isErrorExpected: Bool) {
        XCTAssertEqual(result.games, expectedUsers)
        XCTAssertEqual(result.error != nil, isErrorExpected)
    }
    
    private func execute(url: String, gamesIns: [GamingModel]?)  -> (games: [GamingModel]?, error: Error?){
        repositoryMock.fetchedGaming = gamesIns
        var games: [GamingModel]?
        var error: Error?
        repositoryMock?.execute(request: url).observe(on: MainScheduler.instance).subscribe { result in
            switch result {
            case .next(let game):
                games = game
            case .error(let err):
                error = err
            case .completed:
                games = gamesIns
            }
        }.disposed(by: disposeBag)
        return (games, error)
    }
    
    override  func tearDown() {
        repositoryMock = nil
        disposeBag = nil
        searchMock = []
        gameMock = []
    }
    
}
