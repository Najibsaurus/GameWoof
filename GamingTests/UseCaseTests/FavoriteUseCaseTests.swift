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
import Core


class FavoriteUseCaseTests: XCTestCase {
    
    private var favoriteMock : FavoriteRepositoryMock!
    var disposeBag: DisposeBag!
    private var gameMock : [GamingEntity] = []
    
    override func setUp() {
        favoriteMock = FavoriteRepositoryMock()
        disposeBag = DisposeBag()
        
        let game = GamingEntity()
        game.id = "123"
        game.name = "Solomon's Keep"
        game.backgroundImage = "https://media.rawg.io/media/screenshots/0bb/0bb7c4ac543768fd6c4dd849cc827310.jpeg"
        game.released = "2010-04-03"
        game.rating = 8.0
        
        gameMock = [game]
    }
    
    
    func testCompletedHandlerGameListResultIsInvalidData() {
        let result = execute(gamesIns: gameMock)
        verifying(result, expectedUsers: favoriteMock?.fetchedGaming, isErrorExpected: false)
    }
    
    func testCompletedHandlerGameListResultIsSuccess() {
        let result = execute(gamesIns: nil)
        verifying(result, expectedUsers: nil, isErrorExpected: true)
    }
    
    private func verifying(_ result: (games: [GamingEntity]?, error: Error?), expectedUsers: [GamingEntity]?, isErrorExpected: Bool) {
        XCTAssertEqual(result.games, expectedUsers)
        XCTAssertEqual(result.error != nil, isErrorExpected)
    }
    
    private func execute(gamesIns: [GamingEntity]?)  -> (games: [GamingEntity]?, error: Error?){
        favoriteMock.fetchedGaming = gamesIns
        var games: [GamingEntity]?
        var error: Error?
        favoriteMock?.execute(request: (Any).self).observe(on: MainScheduler.instance).subscribe { result in
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
        favoriteMock = nil
        disposeBag = nil
        gameMock = []
    }
    
    
}
