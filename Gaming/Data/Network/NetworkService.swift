//
//  NetworkService.swift
//  Gaming
//
//  Created by Najib Abdillah on 08/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Foundation
import Alamofire



protocol NetworkServiceProtocol {
    var url: URL? {get set}
    func getRequest<T: Decodable>(completion: @escaping (Result<T, NSError>) -> ())
}



class NetworkService: NetworkServiceProtocol {
    var url: URL?
    
    
    init(url: URL?) {
        self.url = url
    }
    
    
    func getRequest<T>(completion: @escaping (Result<T, NSError>) -> ()) where T : Decodable {
        guard let url = url else {
            completion(.failure(NSError.gettingError(withMessage: "Invalid URL")))
            return
        }
        AF.request(url) { $0.timeoutInterval = 5 }.validate().responseDecodable(of: T.self) { response in
            switch response.result {
                case .success(let users):
                    completion(.success(users))
                case .failure(let error):
                    completion(.failure(error as NSError))
            }
        }
    }
    
    
}

extension NSError {
    static public func gettingError(withMessage message: String) -> NSError {
        return NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
