//
//  APICall.swift
//  Gaming
//
//  Created by Najib Abdillah on 10/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Foundation

struct API {

  static let apiKey = "?&key=413a5a5d6ced4c17bd766261ffd25883"
  static let baseUrl = "https://api.rawg.io/api/games"

}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {
  
  enum Gets: Endpoint {
    case games
    case detail
    case search
    
    public var url: String {
      switch self {
      
      case .games: return "\(API.baseUrl)\(API.apiKey)"
      case .detail: return "\(API.baseUrl)/"
      case .search: return "\(API.baseUrl)?search="
      }
    }
  }
  
}
