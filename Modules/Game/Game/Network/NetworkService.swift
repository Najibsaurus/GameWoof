//
//  NetworkService.swift
//  Game
//
//  Created by Najib Abdillah on 24/06/21.
//

import Alamofire
import Foundation

public class NetworkServices: NetworkProtocol {
    public var url: URL?
    
    
    public init(url: URL?) {
        self.url = url
    }
    
    
    public func getRequest<T>(completion: @escaping (Result<T, NSError>) -> ()) where T : Decodable {
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
