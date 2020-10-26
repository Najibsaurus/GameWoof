//
//  GameViewModel.swift
//  Gaming
//
//  Created by Najib on 13/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import Foundation
import Alamofire


class GameViewModel {
    
    let cellGameIdentifier = "gameListIdentifier"
    let gameCellnib = "GameCell"
    let urlGame = "https://api.rawg.io/api/games"
    let urlSearch  = "https://api.rawg.io/api/games?search="
    let urlDetail = "https://api.rawg.io/api/games/"
    let dummyImage = "https://dummyimage.com/90x90/000/fff"
    let avatar = "https://d17ivq9b7rppb3.cloudfront.net/small/avatar/201905171011432535d9edbd268e421db5dc9a8f23256e.png"
    let name = "Najib Abdillah"
    let htmlFormat = "<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: 15\">%@</span>"
    let defaultRowHeight = 111
    let gameDetailIdentifier = "gameDetail"
    
    var delegate: GameViewModelDelegate?
    var gameList = [Results]()
    var detailData : DetailCall?
       
    func fetchGameData(){
        
        AF.request(urlGame).responseDecodable(of: CallGame.self){ response in
            switch response.result{
            case .success(_):
                self.gameList = response.value?.results ?? [Results]()
                self.delegate?.completedFetchGame()
                
            case .failure(let error):
                print("Error \(error)")
            }
          
        }
     }
    
    func searchGame(Game: String){
        
        guard let urlString = "\(urlSearch)\(Game)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        AF.request(urlString).responseDecodable(of: CallGame.self){ response in
            switch response.result{
             case .success(_):
                self.gameList = response.value?.results ?? [Results]()
                self.delegate?.completedFetchGame()
                      
             case .failure(let error):
                      print("Error \(error)")
                  }
            }
        }
        
    
    
    func DetailGame(idGame: Int) {
    
        guard let urlString = "\(urlDetail)\(idGame)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        AF.request(urlString).responseDecodable(of: DetailCall.self){ response in
              switch response.result{
              case .success(_):
                self.detailData = response.value
                self.delegate?.completedFetchDetail()
                  
              case .failure(let error):
                  print("Error \(error)")
              }
            
          }
    }
    
}

protocol GameViewModelDelegate {
    func completedFetchGame()
    func completedFetchDetail()
}


