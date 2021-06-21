//
//  FavoriteUseCaseTests.swift
//  GamingTests
//
//  Created by Najib Abdillah on 20/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

@testable import Gaming
import XCTest
import RxSwift

class FavoriteUseCaseTests: XCTestCase {
    
    private var repositoryMock : GameRepositoryMock!
    private var ins : FavoriteInteractor!
    var disposeBag: DisposeBag!
    private var gameMock : [GameModel] = []
    
    override func setUp() {
        repositoryMock = GameRepositoryMock()
        repositoryMock.fetchedGames = nil
        ins = FavoriteInteractor(repository: repositoryMock)
        disposeBag = DisposeBag()
    }
    
    
    func testCompletedHandlerGameListResultIsInvalidData() {
        let result = getExecuteFavoriteList(gamesIns: gameMock)
        verifyExecute(result, expectedUsers: repositoryMock.fetchedGames, isErrorExpected: false)
    }
    
    func testCompletedHandlerGameListResultIsSuccess() {
        let result = getExecuteFavoriteList(gamesIns: nil)
        verifyExecute(result, expectedUsers: nil, isErrorExpected: true)
    }
    
    private func getExecuteFavoriteList(gamesIns: [GameModel]?) -> (games: [GameModel]?, error: Error?) {
        repositoryMock.fetchedGames = gamesIns
        var games: [GameModel]?
        var error: Error?
        ins.getFavoriteList().observe(on: MainScheduler.instance).subscribe{ result in
            switch result {
            case .next(let game):
                games = game
            case .error(let err):
                error = err
            case .completed:
                games = self.repositoryMock.fetchedGames

            }
        }.disposed(by: disposeBag)
    
        return (games, error)
    }
    
    

    private func verifyExecute(_ result: (games: [GameModel]?, error: Error?), expectedUsers: [GameModel]?, isErrorExpected: Bool) {
        XCTAssertEqual(result.games, expectedUsers)
        XCTAssertEqual(result.error != nil, isErrorExpected)
    }
    
    
    
    override  func tearDown() {
        repositoryMock = nil
        ins = nil
        disposeBag = nil
        gameMock = []
    }
    
    
    
    
    
    
}
